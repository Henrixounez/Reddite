import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/route_manager.dart';
import 'package:reddite/states/posts_state.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/routes.dart';
import 'package:reddite/widgets/Button.dart';
import 'package:reddite/widgets/UserIcon.dart';

class SubredditIcon extends StatelessWidget {
  final String name;

  SubredditIcon({
    Key key,
    @required this.name
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => RedditeButton(
        onPressed: () async {
          if (postsStore.scrollController != null)
            await postsStore.scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          Timer(Duration(milliseconds: 500), () {
            postsStore.setSubreddit(name.replaceFirst('r/', '').replaceAll('/', ''), true);
            postsStore.loadPosts();
          });
          if (Get.currentRoute != homeRoute)
            Get.until((route) => Get.currentRoute == homeRoute);
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: colorTheme.primaryBg,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: UserIcon(iconUrl: postsStore.subreddits != null && postsStore.subreddits[name] != null ? postsStore.subreddits[name].iconImage.toString() : null)
        ),
      )
    );
  }
}