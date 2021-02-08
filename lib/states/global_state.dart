import 'package:flutter/widgets.dart';
import 'package:reddite/services/reddit_client_service.dart';
import 'package:draw/draw.dart';
import 'package:reddite/utils/reddit_secret.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class GlobalState with ChangeNotifier {
  String _credentials;

  bool get hasCredentials => _credentials != null;
  String get authUrl => _redditClientService.authUrl;
  String get username => _redditClientService.username;
  Redditor get me => _redditClientService.me;

  RedditClientService _redditClientService;  

  Future<void> initApp({
    String authCode
  }) async {
    if (authCode != null) {
      _redditClientService = RedditClientService.createInstalledFlow(authCode);
      await _redditClientService.authorizeClient(authCode);
      await _redditClientService.setMe();
    } else {
      await checkCredentials();
      if (_credentials == null) {
        Reddit reddit = await Reddit.createUntrustedReadOnlyInstance(
          clientId: clientId,
          userAgent: "reddite-app",
          deviceId: Uuid().v4(),
        );
        _redditClientService = RedditClientService(reddit: reddit);
      } else {
        _redditClientService = RedditClientService.restoreInstalledFlow(_credentials);
        await _redditClientService.setMe();
      }
    }
    notifyListeners();
  }

  Future<void> checkCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String credentials = prefs.getString('credentials') ?? null;
    if (credentials != null) {
      _credentials = credentials;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    Reddit reddit = await Reddit.createUntrustedReadOnlyInstance(
      clientId: clientId,
      userAgent: "reddite-app",
      deviceId: Uuid().v4(),
    );
    _redditClientService = RedditClientService(reddit: reddit);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this._credentials = null;
    prefs.setString('credentials', null);
  }
}