import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:get/route_manager.dart';

import 'package:reddite/states/auth.dart';
import 'package:reddite/states/global_state.dart';
import 'package:reddite/states/posts_state.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/routes.dart';
import 'package:reddite/utils/styles.dart';
import 'package:reddite/widgets/Button.dart';
import 'package:reddite/widgets/Input.dart';

import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class _Drawer extends StatelessWidget {
  const _Drawer({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (
      Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 150.0,
              width: 150.0,
              margin: EdgeInsets.symmetric(vertical: 30.0),
              padding: EdgeInsets.all(5.0),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: authStore.me.icon != null
                ? Image.network('${authStore.me.icon}', fit: BoxFit.contain, height: 150.0, width: 150.0,)
                : SizedBox.fromSize(size: Size(150.0, 150.0)),
            ),
            Text(
              'u/${authStore.me.displayName}',
              style: fontMedium.copyWith(
                color: colorTheme.secondaryText,
                fontSize: 21,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.0),
            ListTile(
              leading: Icon(
                FeatherIcons.user,
                size: 18,
                color: colorTheme.primary,
              ),
              title: Text(
                'Profile',
                style: fontMedium.copyWith(color: colorTheme.secondaryText)
              ),
              onTap: () => Get.toNamed(profileRoute)
            ),
            ListTile(
              leading: Icon(
                FeatherIcons.bookmark,
                size: 18,
                color: colorTheme.primary,
              ),
              title: Text(
                'Saved',
                style: fontMedium.copyWith(color: colorTheme.secondaryText)
              ),
              onTap: () => {}
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () => globalStore.logout(),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: Text(
                      'Disconnect',
                      style: fontMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorTheme.primary,
                        fontSize: 18.0,
                      )
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (
      AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Color(0x000000),
        titleSpacing: mainHorizontalPadding,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RedditeButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              rounded: true,
              child: Observer(
                builder: (_) => Container(
                  height: 32,
                  width: 32,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: colorTheme.primaryBg,
                    shape: BoxShape.circle,
                  ),
                  child: authStore.me.icon != null ?
                    Image.network('${authStore.me.icon}', width: 32, height: 32, fit: BoxFit.contain,) :
                    SizedBox.fromSize(size: Size(32, 32)),
                )
              ),
            ),
            SizedBox(width: 16),
            RedditeTopInput(
              onChange: (e) async {
                // List<SubredditRef> list = await authStore.reddit.subreddits.searchByName(e);
              },
              onSubmit: (e) async {
                try {
                  if (postsStore.scrollController != null)
                    await postsStore.scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                  Timer(Duration(milliseconds: 500), () {
                    if (e == "") {
                      postsStore.setSubreddit("all");
                    } else {
                      postsStore.setSubreddit(e);
                    }
                    postsStore.loadPosts();
                  });
                  if (Get.currentRoute != homeRoute)
                    Get.until((route) => Get.currentRoute == homeRoute);
                } catch (e) {}
              },
              hintText: "Search"
            ),
          ]
        ),
      )
    );
  }
}

class RedditeScaffold extends StatelessWidget {
  const RedditeScaffold({
    Key key,
    @required this.body,
    this.showNavbar = true,
    this.extendBodyBehindAppBar = false,
    this.customNavbar,
  }) : super(key: key);

  final Widget body;
  final bool showNavbar;
  final Widget customNavbar;
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        endDrawerEnableOpenDragGesture: false,
        appBar:
          customNavbar != null ? customNavbar :
          showNavbar ? PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: _AppBar()
          ) : null,
        body: this.body,
        drawer: _Drawer(),
      )
    );
  }
}
