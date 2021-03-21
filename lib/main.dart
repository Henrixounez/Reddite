import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:uni_links/uni_links.dart';

import 'package:reddite/states/global_state.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/routes.dart';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String startScreen = loginRoute;

  getLinksStream().listen((event) async {
    try {
      if (await globalStore.initApp(authCode: Uri.parse(event).queryParameters['code']))
        startScreen = homeRoute;
    } catch (e) {
      print(e);
    }
  });

  // Uri initialLink = await getInitialUri();
  try {
    // if (initialLink != null && initialLink.queryParameters["code"] != null) {
    //   await globalStore.initApp(authCode: initialLink.queryParameters["code"]);
    // } else {
    if (await globalStore.initApp())
      startScreen = homeRoute;
    // }
  } catch (e) {
    print(e);
  }
  runApp(MyApp(startScreen: startScreen));
}

class MyApp extends StatelessWidget {
  final String startScreen;

  const MyApp({Key key, this.startScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Reddite',
      initialRoute: this.startScreen,
      getPages: screens.keys.map((key) => GetPage(name: key, page: () => screens[key])).toList(),
      theme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: colorTheme.primaryBg,
        primaryColor: colorTheme.primary,
        accentColor: colorTheme.primary,
        appBarTheme: AppBarTheme(
          color: colorTheme.primary,
          brightness: Brightness.light
        ),
      ),
    );
  }
}