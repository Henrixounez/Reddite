import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:reddite/states/auth.dart';
import 'package:reddite/states/posts_state.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/styles.dart';
import 'package:reddite/widgets/CommentContent.dart';
import 'package:reddite/widgets/Post.dart';
import 'package:reddite/widgets/ProfilePicker.dart';
import 'package:reddite/widgets/Scaffold/Scaffold.dart';

// Profile Screen
//
// Shows the connected user's profile with profile picture and the
// posts the user have created
// The user can click on the profile picture to change it by selecting
// a picture from the gallery or taking a new picture with the camera

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      postsStore.loadProfilePosts();
    });

    return WillPopScope(
      onWillPop: () async {
        postsStore.loadPosts();
        return true;
      },
      child: RedditeScaffold(
        extendBodyBehindAppBar: true,
        showFab: false,
        customNavbar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              postsStore.loadPosts();
              Navigator.pop(context);
            }
          ),
        ),
        body: StreamBuilder(
          stream: postsStore.streamController.stream,
          builder: (context, snapshot) {
            return snapshot.hasData ?
              CustomScrollView(
                controller: postsStore.scrollController,
                slivers: [
                  profileInfos(context),
                  postList(),
                ],
              )
            : loading();
          }
        ),
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
            postsStore.loadProfilePosts(loadMore: true);
          }
          if (postsStore.contents[index] is Submission) {
            Submission post = postsStore.contents[index];
            return Post(
              post: post,
            );
          } else {
            Comment comment = postsStore.contents[index];
            return CommentContent(comment: comment);
          }
        },
        childCount: postsStore.contents.length
      )
    );
  }

  // Top part of the screen with the Profile picture and the name
  // with a gradient behind
  Widget profileInfos(BuildContext context) {
    double iconSize = 150;

    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [
                      colorTheme.secondary,
                      colorTheme.primary,
                    ]
                  )
                ),
              ),
              Container(
                height: 150,
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('u/${authStore.me.displayName}', style: fontMedium.copyWith(color: colorTheme.secondaryText, fontSize: 25))
                  ],
                ),
              )
            ],
          ),
          Positioned(
            left: (MediaQuery.of(context).size.width / 2) - (iconSize / 2),
            top: 150 - (iconSize / 2),
            child: ProfilePicker(iconSize: iconSize)
          )
        ],
      ),
    );
  }

  // Rotating loading circle
  Widget loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}