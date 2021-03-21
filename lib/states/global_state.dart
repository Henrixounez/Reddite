import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mobx/mobx.dart';
import 'package:draw/draw.dart';
import 'package:reddite/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:reddite/states/auth.dart';
import 'package:reddite/utils/reddit_secret.dart';

part 'global_state.g.dart';

class GlobalState = _GlobalState with _$GlobalState;

abstract class _GlobalState with Store {
  String _credentials;

  bool get hasCredentials => _credentials != null;

  @observable
  TextEditingController topInputController = TextEditingController();

  Future<bool> initApp({
    String authCode
  }) async {
    if (authCode != null) {
      authStore.createInstalledFlow(authCode);
      await authStore.authorizeClient(authCode);
      await authStore.setMe();
      return true;
    } else {
      await checkCredentials();
      if (_credentials == null) {
        Reddit reddit = await Reddit.createUntrustedReadOnlyInstance(
          clientId: clientId,
          userAgent: "reddite-app",
          deviceId: Uuid().v4(),
        );
        authStore.setReddit(reddit);
      } else {
        authStore.restoreInstalledFlow(_credentials);
        await authStore.setMe();
        return true;
      }
    }
    return false;
  }

  Future<void> checkCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String credentials = prefs.getString('credentials') ?? null;
    if (credentials != null) {
      _credentials = credentials;
    }
  }

  Future<void> logout() async {
    Reddit reddit = await Reddit.createUntrustedReadOnlyInstance(
      clientId: clientId,
      userAgent: "reddite-app",
      deviceId: Uuid().v4(),
    );
    authStore.setReddit(reddit);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this._credentials = null;
    prefs.setString('credentials', null);
    Get.toNamed(loginRoute);
  }
}

final globalStore = GlobalState();