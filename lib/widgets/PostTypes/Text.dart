import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/styles.dart';

class PostText extends StatelessWidget {
  final Submission post;

  const PostText({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (post.selftext.length > 0) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            post.selftext,
            style: fontBook.copyWith(color: darkGrey),
            textAlign: TextAlign.start,
          ),
        )
      );
    } else {
      return SizedBox.shrink();
    } 
  }
}