// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Auth on _Auth, Store {
  Computed<String> _$authUrlComputed;

  @override
  String get authUrl => (_$authUrlComputed ??=
          Computed<String>(() => super.authUrl, name: '_Auth.authUrl'))
      .value;
  Computed<String> _$usernameComputed;

  @override
  String get username => (_$usernameComputed ??=
          Computed<String>(() => super.username, name: '_Auth.username'))
      .value;
  Computed<Redditor> _$meComputed;

  @override
  Redditor get me =>
      (_$meComputed ??= Computed<Redditor>(() => super.me, name: '_Auth.me'))
          .value;

  final _$redditAtom = Atom(name: '_Auth.reddit');

  @override
  Reddit get reddit {
    _$redditAtom.reportRead();
    return super.reddit;
  }

  @override
  set reddit(Reddit value) {
    _$redditAtom.reportWrite(value, super.reddit, () {
      super.reddit = value;
    });
  }

  final _$_meAtom = Atom(name: '_Auth._me');

  @override
  Redditor get _me {
    _$_meAtom.reportRead();
    return super._me;
  }

  @override
  set _me(Redditor value) {
    _$_meAtom.reportWrite(value, super._me, () {
      super._me = value;
    });
  }

  final _$authorizeClientAsyncAction = AsyncAction('_Auth.authorizeClient');

  @override
  Future<void> authorizeClient(String authCode) {
    return _$authorizeClientAsyncAction
        .run(() => super.authorizeClient(authCode));
  }

  final _$setMeAsyncAction = AsyncAction('_Auth.setMe');

  @override
  Future<void> setMe() {
    return _$setMeAsyncAction.run(() => super.setMe());
  }

  final _$_AuthActionController = ActionController(name: '_Auth');

  @override
  dynamic setReddit(Reddit reddit) {
    final _$actionInfo =
        _$_AuthActionController.startAction(name: '_Auth.setReddit');
    try {
      return super.setReddit(reddit);
    } finally {
      _$_AuthActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic createInstalledFlow(String authCode) {
    final _$actionInfo =
        _$_AuthActionController.startAction(name: '_Auth.createInstalledFlow');
    try {
      return super.createInstalledFlow(authCode);
    } finally {
      _$_AuthActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic restoreInstalledFlow(String credentials) {
    final _$actionInfo =
        _$_AuthActionController.startAction(name: '_Auth.restoreInstalledFlow');
    try {
      return super.restoreInstalledFlow(credentials);
    } finally {
      _$_AuthActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
reddit: ${reddit},
authUrl: ${authUrl},
username: ${username},
me: ${me}
    ''';
  }
}
