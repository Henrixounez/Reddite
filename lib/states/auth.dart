import 'package:mobx/mobx.dart';
import 'package:draw/draw.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:reddite/utils/reddit_secret.dart';

part 'auth.g.dart';

class Auth = _Auth with _$Auth;

abstract class _Auth with Store {
  @observable
  Reddit reddit;

  @observable
  Redditor _me;

  @computed
  String get authUrl => reddit.auth.url(['*'], "reddite").toString();

  @computed
  String get username => _me != null ? me.displayName : '';

  @computed
  Redditor get me => _me;

  @action
  setReddit(Reddit reddit) {
    this.reddit = reddit;
  }

  @action
  createInstalledFlow(String authCode) {
    final Reddit reddit = Reddit.createInstalledFlowInstance(
      clientId: clientId,
      userAgent: "reddite-app",
      redirectUri: Uri.parse("reddite://reddite.dev"),
    );
    this.reddit = reddit;
  }

  @action
  restoreInstalledFlow(String credentials) {
    final Reddit reddit = Reddit.restoreInstalledAuthenticatedInstance(
      credentials,
      clientId: clientId,
      userAgent: "reddite-app"
    );

    this.reddit = reddit;
  }

  @action
  Future<void> authorizeClient(String authCode) async {
    reddit.auth.url(['*'], "reddite-auth");
    await reddit.auth.authorize(authCode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String credentials = reddit.auth.credentials.toJson();
    prefs.setString('credentials', credentials);
  }

  @action
  Future<void> setMe() async {
    Redditor redditor = await reddit.user.me();
    _me = redditor;
  }

  @action
  Future<void> refreshMe() async {
    Redditor redditor = await reddit.redditor(_me.displayName).populate();
    _me = redditor;
  }
}

final authStore = Auth();