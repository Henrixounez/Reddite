import 'package:draw/draw.dart';
import 'package:reddite/utils/reddit_secret.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RedditClientService {
  final Reddit reddit;

  RedditClientService({this.reddit});

  Redditor _me;

  String get authUrl => reddit.auth.url(['*'], "reddite").toString();
  String get username => _me != null ? me.displayName : '';
  Redditor get me => _me;

  factory RedditClientService.createInstalledFlow(String authCode) {
    final Reddit reddit = Reddit.createInstalledFlowInstance(
      clientId: clientId,
      userAgent: "reddite-app",
      redirectUri: Uri.parse("reddite://reddite.dev"),
    );

    return RedditClientService(reddit: reddit);
  }

  factory RedditClientService.restoreInstalledFlow(String credentials) {
    final Reddit reddit = Reddit.restoreInstalledAuthenticatedInstance(
      credentials,
      clientId: clientId,
      userAgent: "reddite-app"
    );

    return RedditClientService(reddit: reddit);
  }

  Future<void> authorizeClient(String authCode) async {
    reddit.auth.url(['*'], "reddite-auth");
    await reddit.auth.authorize(authCode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String credentials = reddit.auth.credentials.toJson();
    prefs.setString('credentials', credentials);
  }

  Future<void> setMe() async {
    Redditor redditor = await reddit.user.me();
    _me = redditor;
  }
}