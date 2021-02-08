import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddite/screens/login_screen.dart';
import 'package:reddite/states/global_state.dart';
import 'package:reddite/utils/colors.dart';
import 'package:uni_links/uni_links.dart';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GlobalState globalState = GlobalState();

  getLinksStream().listen((event) async {
    try {
      await globalState.initApp(authCode: Uri.parse(event).queryParameters['code']);
    } catch (e) {}
  });

  Uri initialLink = await getInitialUri();
  try {
    if (initialLink != null && initialLink.queryParameters["code"] != null) {
      await globalState.initApp(authCode: initialLink.queryParameters["code"]);
    } else {
      await globalState.initApp();
    }
  } catch (e) {}
  runApp(MyApp(
    globalState: globalState,
  ));
}

class MyApp extends StatelessWidget {
  final GlobalState globalState;

  const MyApp({Key key, this.globalState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GlobalState>.value(
          value: globalState
        )
      ],
      child: MaterialApp(
        title: 'Reddite',
        theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: white,
          primaryColor: redditOrange,
          accentColor: redditOrange,
          appBarTheme: AppBarTheme(
            color: redditOrange,
            brightness: Brightness.light
          ),
          textTheme: Theme.of(context).textTheme
          .copyWith(
            button: Theme.of(context).textTheme.button.apply(
              fontSizeFactor: 1.2
            )
          )
          .apply(
            fontFamily: 'FranklinGothic',
            bodyColor: white,
            displayColor: white
          ),
        ),
        home: LoginScreen(),
        // home: HomeScreen(),
      )
    );
  }
}