import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:draw/draw.dart';
import 'package:reddite/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/reddit_secret.dart';
import 'package:reddite/widgets/Button.dart';
import 'package:reddite/widgets/Scaffold/Scaffold.dart';

// Login Screen
//
// Page with a button that redirects to Reddit Oauth for authentication

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return RedditeScaffold(
      showNavbar: false,
      showFab: false,
      body: Container(
        padding: EdgeInsets.all(50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorTheme.primary,
              colorTheme.secondary
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 8
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/reddite.png',
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  SizedBox(height: 30,),
                  Text(
                    'Reddite',
                    style: fontTitle.copyWith(fontSize: 50)
                  ),
                ],
              ),
            ),
            RedditeLoginButton(
              onPressed: () {
                Reddit reddit = Reddit.createInstalledFlowInstance(
                  clientId: clientId,
                  userAgent: "reddite-app",
                  redirectUri:  Uri.parse("reddite://reddite.dev"),
                );
                launch(
                  reddit.auth.url(
                    ['*'],
                    "reddite-app"
                  ).toString()
                );
              },
              child: Text('Sign in', style: fontMedium.copyWith(fontSize: 15)),
            ),
          ],
        )
      )
    );
  }
}