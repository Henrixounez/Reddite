import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddite/states/posts_state.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/styles.dart';
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


class Post extends StatelessWidget {
  final Submission post;

  Post({
    Key key,
    @required this.post
  }) : super(key: key);

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

    return Column(
      children: [
        titleRow(),
        content(type),
      ]
    );
  }

  Widget titleRow() {
    Subreddit subreddit = postsStore.subreddits[post.subreddit.path];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
              InkWell(
                onTap: () {},
                child: Icon(Icons.bookmark_outline, color: white,)
              )
            ],
          ),
          SizedBox(height: 16,),
          Text(
            post.title,
            style: fontBook.copyWith(fontSize: 16),
          ),
        ]
      ),
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