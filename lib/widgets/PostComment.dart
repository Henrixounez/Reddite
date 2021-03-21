import 'package:flutter/material.dart';
import 'package:draw/draw.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';

import 'package:reddite/states/focus_post_state.dart';

import 'package:reddite/utils/functions.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/styles.dart';

import 'package:reddite/widgets/Button.dart';
import 'package:reddite/widgets/UserIcon.dart';

class PostComment extends StatefulWidget {
  final Comment comment;

  PostComment({
    Key key,
    @required this.comment,
  }) : super(key: key);

  @override
  _PostCommentState createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {

  Redditor author;
  bool collapsed = true;

  @override
  void initState() {
    super.initState();
    loadAuthor();
  }

  loadAuthor() async {
    Redditor _author = focusPostStore.authors.containsKey(widget.comment.author) ?
      focusPostStore.authors[widget.comment.author] :
      await focusPostStore.loadAuthor(widget.comment.author);

    if (this.mounted) {
      setState(() {
        author = _author;
      });
    }
  }

  Future<List<Widget>> replies(List<dynamic> comments) async {
    return flatten<Widget>(
      (await Future.wait(
        comments.map((dynamic e) async {
          if (e is Comment) {
            return PostComment(comment: e);
          } else if (e is MoreComments) {
            if (e.isLoadMoreComments)
              return replies(await e.comments());
            return SizedBox.shrink();
          } else {
            return SizedBox.shrink();
          }
        })
      )).toList()
    );
  }

  void toggleCollapse() async {
    setState(() {
      collapsed = !(collapsed != null ? collapsed : true);
    });
  }

  @override
  Widget build(BuildContext context) {
    Comment comment = widget.comment;

    return Column(
      children: [
        RedditeButton(
          rounded: false,
          onLongPressed: this.toggleCollapse,
          child: Container(
            margin: EdgeInsets.only(
              top: comment.depth == 0 ? 8 : 0
            ),
            padding: EdgeInsets.only(
              left: (comment.depth.toDouble() + 1) * 12,
              top: 8,
              bottom: 8,
            ),
            child: Column(
              children: [
                topRow(comment),
                SizedBox(height: 8),
                contentRow(comment),
                SizedBox(height: 8),
                bottomRow(comment),
              ],
            ),
          ),
        ),
        if (!(collapsed != null ? collapsed : true))
          FutureBuilder(
            future: replies(comment.replies?.comments ?? []),
            builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return Column(children: snapshot.data);
                default:
                  return SizedBox.shrink();
              }
            },
          )
      ]
    );
  }

  Widget topRow(Comment comment) {
    return Row(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: colorTheme.primaryBg,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: UserIcon(iconUrl: focusPostStore?.authors[comment?.author]?.icon)
        ),
        SizedBox(width: 8),
        Row(
          children: [
            Text('u/${comment.author}', style: fontMedium.apply(color: colorTheme.primary)),
            Text(' - ${timeAgo(comment.createdUtc)}', style: fontBook.apply(color: colorTheme.primaryText))
          ],
        )
      ],
    );
  }

  Widget contentRow(Comment comment) {
    return Row(
      children: [
        Flexible(
          child: Text(HtmlUnescape().convert(comment.body)),
        )
      ],
    );
  }

  Widget bottomRow(Comment comment) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Text(
              (comment.replies?.comments?.length ?? 0).toString(),
              style: fontBook.copyWith(fontSize: 11, color: colorTheme.secondaryText)
            ),
            SizedBox(width: 4),
            Icon(
              FeatherIcons.messageSquare,
              color: colorTheme.secondaryText,
              size: 16,
            ),
          ]
        ),
        SizedBox(width: 12),
        Row(
          children: [
            RedditeButton(
              onPressed: () async {
                if (comment.likes != true)
                  await comment.upvote();
                else
                  await comment.clearVote();
                setState(() => {
                  comment = comment
                });
              },
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Icon(
                  FeatherIcons.chevronUp,
                  color: comment.likes == true ? colorTheme.upvote : colorTheme.secondaryText,
                  size: 20
                ),
              )
            ),
            SizedBox(
              width: 30,
              child: Text(
                NumberFormat.compactCurrency(
                  decimalDigits: 2,
                  symbol: '',
                ).format(comment.upvotes).replaceAll('.00', ''),
                style: fontBook.copyWith(fontSize: 11, color: colorTheme.secondaryText,),
                textAlign: TextAlign.center,
              ),
            ),
            RedditeButton(
              onPressed: () async {
                if (comment.likes != false)
                  await comment.downvote();
                else
                  await comment.clearVote();
                setState(() => {
                  comment = comment
                });
              },
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Icon(
                  FeatherIcons.chevronDown,
                  color: comment.likes == false ? colorTheme.downvote : colorTheme.secondaryText,
                  size: 20
                ),
              )
            ),
          ]
        ),
      ]
    );
  }
}