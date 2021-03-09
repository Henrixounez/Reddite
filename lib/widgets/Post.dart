import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:draw/draw.dart';
import 'package:get/route_manager.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:reddite/states/focus_post_state.dart';

import 'package:reddite/states/posts_state.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/routes.dart';
import 'package:reddite/utils/styles.dart';
import 'package:reddite/widgets/Button.dart';
import 'package:reddite/widgets/PostTypes/Image.dart';
import 'package:reddite/widgets/PostTypes/Text.dart';
import 'package:reddite/widgets/PostTypes/Video.dart';

enum PostType {
  Text,
  Link,
  Image,
  Gallery,
  Video,
  Gif,
  Youtube,
  Tweet,
  Gfycat,
  Imgur
}


class Post extends StatefulWidget {
  final Submission post;

  Post({
    Key key,
    @required this.post,
  }) : super(key: key);

  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  Submission post;

  @override
  initState() {
    super.initState();
    post = widget.post;
  }
  
  @override
  void didUpdateWidget(Post oldWidget) {
    super.didUpdateWidget(oldWidget);
    post = widget.post;
  }

  PostType getPostType() {
    if (post.isSelf)
      return PostType.Text;
    if (RegExp(r"\.(gif|jpe?g|bmp|png)$").hasMatch(post.url.toString()))
      return PostType.Image;
    if (RegExp(r"(?:youtube\.com\/\S*(?:(?:\/e(?:mbed))?\/|watch\?(?:\S*?&?v\=))|youtu\.be\/)([a-zA-Z0-9_-]{6,11})")
        .hasMatch(post.url.toString()))
      return PostType.Youtube;
    if (["v.redd.it", "i.redd.it", "i.imgur.com"].contains(post.domain) ||
        post.url.toString().contains('.gifv'))
      return PostType.Gif;
    if (post.isGallery ?? false)
      return PostType.Gallery;
    if (post.isVideo)
      return PostType.Video;
    if (post.domain == "twitter.com")
      return PostType.Tweet;
    if (post.domain == "gfycat.com")
      return PostType.Gfycat;
    if (post.domain == "imgur.com")
      return PostType.Imgur;
    return PostType.Text;
  }

  @override
  Widget build(BuildContext context) {
    PostType type = this.getPostType();

    return RedditeButton(
      onPressed: () {
        focusPostStore.setPost(post);
        Get.toNamed(postRoute);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            topRow(),
            titleRow(),
            content(type),
            bottomRow(),
          ]
        )
      )
    );
  }

  Widget topRow() {
    Subreddit subreddit = postsStore.subreddits[post.subreddit.path];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: mainHorizontalPadding, vertical: 16),
      color: redditOrange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: subreddit != null && subreddit?.iconImage.toString() != '' ? Image.network(
                  subreddit?.iconImage.toString(),
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain
                ) : SizedBox.fromSize(size: Size(30, 30)),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('r/${post.subreddit?.displayName}', style: fontMedium),
                  SizedBox(height: 6),
                  Text('Posted by: u/${post.author}', style: fontBook.copyWith(fontSize: 10)),
                ],
              ),
              Spacer(),
              RedditeButton(
                child: Icon(FeatherIcons.bookmark, color: white, size: 16),
                onPressed: () {}
              )
            ],
          ),
        ]
      ),
    );
  }

  Widget titleRow() {
    return (
      Container(
        color: darkGrey,
        padding: EdgeInsets.symmetric(horizontal: mainHorizontalPadding, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              HtmlUnescape().convert(post.title),
              style: fontBook.copyWith(fontSize: 14),
            ),
          ]
        )
      )
    );
  }

  Widget bottomRow() {
    return Container(
      color: darkGrey,
      height: 38,
      padding: EdgeInsets.symmetric(horizontal: mainHorizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              RedditeButton(
                onPressed: () async {
                  if (post.likes != true)
                    await post.upvote();
                  else
                    await post.clearVote();
                  setState(() => {
                    post = post
                  });
                },
                child: Icon(
                  FeatherIcons.chevronUp,
                  color: post.likes == true ? upvoteOrange: white,
                  size: 20
                ),
              ),
              Text(
                NumberFormat.compactCurrency(
                  decimalDigits: 2,
                  symbol: '',
                ).format(post.upvotes),
                style: fontBook.copyWith(fontSize: 11)
              ),
              RedditeButton(
                onPressed: () async {
                  if (post.likes != false)
                    await post.downvote();
                  else
                    await post.clearVote();
                  setState(() => {
                    post = post
                  });
                },
                child: Icon(
                  FeatherIcons.chevronDown,
                  color: post.likes == false ? downvoteBlue : white,
                  size: 20
                ),
              ),
            ]
          ),
          Row(
            children: [
              RedditeButton(
                onPressed: () {},
                child: Icon(FeatherIcons.link, color: redditOrange, size: 16),
              ),
              SizedBox(width: 10),
              RedditeButton(
                onPressed: () {},
                child: Icon(FeatherIcons.messageSquare, color: white, size: 16)
              ),
            ],
          )
        ],
      )
    );
  }

  Widget content(PostType type) {
    switch (type) {
      case PostType.Text:
        return PostText(post: post);
      case PostType.Image:
        return PostImage(post: post);
      case PostType.Youtube:
        return notHandled(type);
      case PostType.Gif:
        return PostVideo(post: post, isGif: true);
      case PostType.Gallery:
        return notHandled(type);
      case PostType.Video:
        return PostVideo(post: post);
      case PostType.Tweet:
        return notHandled(type);
      case PostType.Gfycat:
        return notHandled(type);
      case PostType.Imgur:
        return notHandled(type);
      default:
        return notHandled(type);
    }
  }

  Widget notHandled(PostType type) {
    return Text(
      'Type ${type.toString()} no handled yet.',
      style: fontMedium.copyWith(color: darkGrey)
    );
  }
}