// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_post_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FocusPostState on _FocusPostState, Store {
  Computed<Submission> _$postComputed;

  @override
  Submission get post => (_$postComputed ??=
          Computed<Submission>(() => super.post, name: '_FocusPostState.post'))
      .value;
  Computed<Map<String, Redditor>> _$authorsComputed;

  @override
  Map<String, Redditor> get authors => (_$authorsComputed ??=
          Computed<Map<String, Redditor>>(() => super.authors,
              name: '_FocusPostState.authors'))
      .value;

  final _$_postAtom = Atom(name: '_FocusPostState._post');

  @override
  Submission get _post {
    _$_postAtom.reportRead();
    return super._post;
  }

  @override
  set _post(Submission value) {
    _$_postAtom.reportWrite(value, super._post, () {
      super._post = value;
    });
  }

  final _$_authorsAtom = Atom(name: '_FocusPostState._authors');

  @override
  Map<String, Redditor> get _authors {
    _$_authorsAtom.reportRead();
    return super._authors;
  }

  @override
  set _authors(Map<String, Redditor> value) {
    _$_authorsAtom.reportWrite(value, super._authors, () {
      super._authors = value;
    });
  }

  final _$loadAuthorAsyncAction = AsyncAction('_FocusPostState.loadAuthor');

  @override
  Future<Redditor> loadAuthor(String v) {
    return _$loadAuthorAsyncAction.run(() => super.loadAuthor(v));
  }

  final _$_FocusPostStateActionController =
      ActionController(name: '_FocusPostState');

  @override
  dynamic setPost(Submission v) {
    final _$actionInfo = _$_FocusPostStateActionController.startAction(
        name: '_FocusPostState.setPost');
    try {
      return super.setPost(v);
    } finally {
      _$_FocusPostStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic unload() {
    final _$actionInfo = _$_FocusPostStateActionController.startAction(
        name: '_FocusPostState.unload');
    try {
      return super.unload();
    } finally {
      _$_FocusPostStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
post: ${post},
authors: ${authors}
    ''';
  }
}
