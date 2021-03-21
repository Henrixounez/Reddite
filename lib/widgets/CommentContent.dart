import 'package:draw/draw.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/functions.dart';
import 'package:reddite/utils/styles.dart';

class CommentContent extends StatelessWidget {
  final Comment comment;

  CommentContent({
    Key key,
    this.comment
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Submission>(
      future: comment.submission.populate(),
      builder: (BuildContext context, AsyncSnapshot<Submission> snapshot) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: colorTheme.secondaryBg, width: 0.5)
            )
          ),
          padding: EdgeInsets.symmetric(horizontal: mainHorizontalPadding, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(snapshot.hasData ? snapshot.data.title : '', style: fontMedium.copyWith(color: colorTheme.secondaryText, fontSize: 16)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'r/${comment.subreddit.displayName} - ${timeAgo(comment.createdUtc)} - ${comment.upvotes}',
                    style: fontBook.copyWith(color: colorTheme.secondaryText),
                  ),
                  Icon(FeatherIcons.chevronUp, size: 16)
                ],
              ),
              Text(HtmlUnescape().convert(comment.body), style: fontBook.copyWith(color: colorTheme.secondaryText),),
            ]
          )
        );
      }
    );
  }
}