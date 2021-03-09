import 'package:draw/draw.dart';
import 'package:flutter/widgets.dart';
import 'package:reddite/states/auth.dart';
import 'package:reddite/states/focus_post_state.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/styles.dart';
import 'package:reddite/widgets/Button.dart';
import 'package:reddite/widgets/Post.dart';
import 'package:reddite/widgets/Scaffold.dart';

List<Widget> flatten(List arr) => 
  arr.fold([], (value, element) => 
   [
     ...value, 
     ...(element is List ? flatten(element) : [element])
   ]);

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
    print('Rebuild ?');
    // print(focusPostStore.post.comments);
    if (focusPostStore.post != null) {
      return WillPopScope(
        onWillPop: () async {
          print('Will pop ?');
          focusPostStore.unload();
          this.authors.clear(); 
          return true;
        },
        child: RedditeScaffold(
          body: ListView(
            children: [
              Post(post: focusPostStore.post),
              ...commentList(focusPostStore.post.comments.comments),
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
    return flatten(comments.toList().map((dynamic e) {
      if (e is Comment) {
        return commentRow(e);
      } else if (e is MoreComments) {
        return commentList(e.children);
      } else {
        return SizedBox.shrink();
      }
    }).toList());
  }

  List<Widget> commentRow(Comment comment) {
    if (!this.authors.containsKey(comment.author))
      this.loadAuthor(comment.author);

    return [
      RedditeButton(
        onLongPressed: () {
          if (uncollapsed.contains(comment.id))
            uncollapsed.remove(comment.id);
          else
            uncollapsed.add(comment.id);
          setState(() {
            uncollapsed = uncollapsed;
          });
        },
        child: Container(
          padding: EdgeInsets.only(
            left: (comment.depth.toDouble() + 1) * 12,
            top: 16,
            bottom: 16,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: this.authors.containsKey(comment.author) ? Image.network(
                      this.authors[comment.author].icon,
                      width: 20,
                      height: 20,
                    ) : SizedBox(height: 20, width: 20),
                  ),
                  SizedBox(width: 8),
                  Text(comment.author, style: fontMedium.apply(color: redditOrange)),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(comment.body),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      if (uncollapsed.contains(comment.id))
        ...commentList(comment.replies?.comments ?? [])
    ];
  }
}