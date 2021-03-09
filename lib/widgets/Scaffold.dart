import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:reddite/states/auth.dart';
import 'package:reddite/states/posts_state.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/styles.dart';
import 'package:reddite/widgets/Input.dart';

class RedditeScaffold extends StatelessWidget {
  const RedditeScaffold({
    Key key,
    @required this.body,
    this.showNavbar = true,
    this.scrollController,
  }) : super(key: key);

  final Widget body;
  final bool showNavbar;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: showNavbar ? appBar() : null,
        body: this.body,
      )
    );
  }

  Widget appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      shadowColor: Color(0x000000),
      titleSpacing: mainHorizontalPadding,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Observer(
            builder: (_) => Container(
              height: 32,
              width: 32,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.all(Radius.circular(32))
              ),
              child: authStore.me.icon != null ?
                Image.network('${authStore.me.icon}', width: 32, height: 32, fit: BoxFit.contain,) :
                SizedBox.fromSize(size: Size(32, 32)),
            )
          ),
          SizedBox(width: 16,),
          RedditeTopInput(
            onChange: (e) async {
              // List<SubredditRef> list = await authStore.reddit.subreddits.searchByName(e);
            },
            onSubmit: (e) async {
              if (scrollController != null)
                await scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
              Timer(Duration(milliseconds: 500), () {
                if (e == "") {
                  postsStore.setSubreddit("all");
                } else {
                  postsStore.setSubreddit(e);
                }
                postsStore.loadPosts();
              });
            },
            hintText: "Search"
          ),
        ]
      ),
    );
  }
}