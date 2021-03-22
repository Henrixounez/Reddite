import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:reddite/states/posts_state.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/styles.dart';
import 'package:reddite/widgets/Post.dart';
import 'package:reddite/widgets/Scaffold/Scaffold.dart';
import 'package:reddite/widgets/SortBar.dart';

class SavedScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      postsStore.loadSavedPosts();
    });

    return WillPopScope(
      onWillPop: () async {
        postsStore.loadPosts();
        return true;
      },
      child: RedditeScaffold(
        showFab: false,
        customNavbar: AppBar(
          backgroundColor: colorTheme.secondaryBg,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              postsStore.loadPosts();
              Navigator.pop(context);
            }
          ),
          title: Text('Saved', style: fontMedium.copyWith(fontSize: 16)),
        ),
        body: StreamBuilder(
          stream: postsStore.streamController.stream,
          builder: (context, snapshot) {
            return snapshot.hasData ?
              CustomScrollView(
                controller: postsStore.scrollController,
                slivers: [
                  postList(),
                ],
              )
            : loading();
          }
        )
      )
    );
  }

  Widget postList() {
    return  SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          bool loadMore = (index > postsStore.contents.length - 10);
          if (loadMore && !postsStore.isLoading) {
            postsStore.loadSavedPosts(loadMore: true);
          }
          if (postsStore.contents[index] is Submission) {
            Submission post = postsStore.contents[index];
            return Post(
              post: post,
            );
          } else {
            return SizedBox.shrink();
          }
        },
        childCount: postsStore.contents.length
      )
    );
  }

  Widget sortBarSliver() {
    return SliverAppBar(
      titleSpacing: 0,
      toolbarHeight: 32,
      floating: true,
      stretch: true,
      automaticallyImplyLeading: false,
      title: SortBar(),
    );
  }

  Widget loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}