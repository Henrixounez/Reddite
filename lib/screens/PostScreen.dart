import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:draw/draw.dart';

import 'package:reddite/states/focus_post_state.dart';
import 'package:reddite/utils/colors.dart';

import 'package:reddite/utils/functions.dart';

import 'package:reddite/widgets/Post.dart';
import 'package:reddite/widgets/PostComment.dart';
import 'package:reddite/widgets/Scaffold/Scaffold.dart';

// Post Screen
//
// Screen that display currently focused post after clicking on it
// Shows the post and its replies, each reply can be expanded to show
// its own replies

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (focusPostStore.post != null) {
      return WillPopScope(
        onWillPop: () async {
          focusPostStore.unload();
          return true;
        },
        child: RedditeScaffold(
          customNavbar: AppBar(
            backgroundColor: colorTheme.primary,
            shadowColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          body: ListView(
            children: [
              Post(post: focusPostStore.post),
              ...commentList(focusPostStore.post?.comments?.comments ?? []),
            ],
          )
        )
      );
    } else {
      return RedditeScaffold(
        body: Center(
          child: Text('No post selected')
        )
      );
    }
  }

  // Generating top replies list
  List<Widget> commentList(List<dynamic> comments) {
    return flatten<Widget>(comments.toList().map((dynamic e) {
      if (e is Comment) {
        return PostComment(comment: e);
      } else if (e is MoreComments) {
        return commentList(e.children);
      } else {
        return SizedBox.shrink();
      }
    }).toList());
  }
}