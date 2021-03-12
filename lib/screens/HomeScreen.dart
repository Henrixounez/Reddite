import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:reddite/states/posts_state.dart';
import 'package:reddite/widgets/Post.dart';
import 'package:reddite/widgets/Scaffold.dart';
import 'package:reddite/widgets/SortBar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    postsStore.loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (postsStore.lastSubreddits.length > 0) {
          postsStore.popSubreddit();
          postsStore.loadPosts();
          return false;
        } else {
          return true;
        }
      },
      child: RedditeScaffold(
        body: StreamBuilder(
          stream: postsStore.streamController.stream,
          builder: (context, snapshot) {
            return snapshot.hasData ?
              CustomScrollView(
                controller: postsStore.scrollController,
                slivers: [
                  sortBarSliver(),
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
          Submission post = postsStore.contents[index];
          bool loadMore = (index > postsStore.contents.length - 10);
          if (loadMore && !postsStore.isLoading)
            postsStore.loadPosts(loadMore: true);
          return Post(
            post: post,
          );
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