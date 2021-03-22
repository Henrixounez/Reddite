import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/route_manager.dart';
import 'package:reddite/states/auth.dart';
import 'package:reddite/states/global_state.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/routes.dart';
import 'package:reddite/utils/styles.dart';

class RedditeDrawer extends StatelessWidget {
  const RedditeDrawer({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (
      Drawer(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    height: 150.0,
                    width: 150.0,
                    margin: EdgeInsets.symmetric(vertical: 30.0),
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
                    onTap: () => Get.toNamed(savedRoute)
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
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
            )
          ],
        ),
      )
    );
  }
}