import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:draw/draw.dart';

import 'package:reddite/states/auth.dart';
import 'package:reddite/states/focus_post_state.dart';

import 'package:reddite/utils/functions.dart';

import 'package:reddite/widgets/Post.dart';
import 'package:reddite/widgets/PostComment.dart';
import 'package:reddite/widgets/Scaffold.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<String> uncollapsed = [];
  Map<String, Redditor> authors = {};

  loadAuthor(String v) async {
    Redditor newAuthor = await authStore.reddit.redditor(v).populate();
    setState(() {
      this.authors[v] = newAuthor;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (focusPostStore.post != null) {
      return WillPopScope(
        onWillPop: () async {
          focusPostStore.unload();
          this.authors.clear(); 
          return true;
        },
        child: RedditeScaffold(
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