import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:reddite/states/posts_state.dart';
import 'package:reddite/widgets/Post.dart';
import 'package:reddite/widgets/Scaffold/Scaffold.dart';
import 'package:reddite/widgets/SortBar.dart';

// Home Screen
//
// Main page that display currently selected Subreddit's posts
// with a StreamBuilder
// Uses Slivers to display both infinite posts and a SortBar which
// appear when scrolling a little bit up

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    // Load posts from currently selected subreddit
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

  // Main list of posts, it is updated by the StreamBuilder
  // with the new content available from the PostsStore
  Widget postList() {
    return  SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          bool loadMore = (index > postsStore.contents.length - 10);
          if (loadMore && !postsStore.isLoading) {
            postsStore.loadPosts(loadMore: true);
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

  // Making the SortBar accessible by scrolling a little bit up
  // instead of needing to go all the way up
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

  // Rotating loading circle
  Widget loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}