// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostsState on _PostsState, Store {
  Computed<List<Submission>> _$contentsComputed;

  @override
  List<Submission> get contents =>
      (_$contentsComputed ??= Computed<List<Submission>>(() => super.contents,
              name: '_PostsState.contents'))
          .value;
  Computed<Map<String, Redditor>> _$authorsComputed;

  @override
  Map<String, Redditor> get authors => (_$authorsComputed ??=
          Computed<Map<String, Redditor>>(() => super.authors,
              name: '_PostsState.authors'))
      .value;

  final _$_contentsAtom = Atom(name: '_PostsState._contents');

  @override
  List<Submission> get _contents {
    _$_contentsAtom.reportRead();
    return super._contents;
  }

  @override
  set _contents(List<Submission> value) {
    _$_contentsAtom.reportWrite(value, super._contents, () {
      super._contents = value;
    });
  }

  final _$_authorsAtom = Atom(name: '_PostsState._authors');

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

  final _$subredditsAtom = Atom(name: '_PostsState.subreddits');

  @override
  ObservableMap<String, Subreddit> get subreddits {
    _$subredditsAtom.reportRead();
    return super.subreddits;
  }

  @override
  set subreddits(ObservableMap<String, Subreddit> value) {
    _$subredditsAtom.reportWrite(value, super.subreddits, () {
      super.subreddits = value;
    });
  }

  final _$lastSubredditsAtom = Atom(name: '_PostsState.lastSubreddits');

  @override
  List<String> get lastSubreddits {
    _$lastSubredditsAtom.reportRead();
    return super.lastSubreddits;
  }

  @override
  set lastSubreddits(List<String> value) {
    _$lastSubredditsAtom.reportWrite(value, super.lastSubreddits, () {
      super.lastSubreddits = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_PostsState.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$sortingAtom = Atom(name: '_PostsState.sorting');

  @override
  String get sorting {
    _$sortingAtom.reportRead();
    return super.sorting;
  }

  @override
  set sorting(String value) {
    _$sortingAtom.reportWrite(value, super.sorting, () {
      super.sorting = value;
    });
  }

  final _$subredditAtom = Atom(name: '_PostsState.subreddit');

  @override
  String get subreddit {
    _$subredditAtom.reportRead();
    return super.subreddit;
  }

  @override
  set subreddit(String value) {
    _$subredditAtom.reportWrite(value, super.subreddit, () {
      super.subreddit = value;
    });
  }

  final _$scrollControllerAtom = Atom(name: '_PostsState.scrollController');

  @override
  ScrollController get scrollController {
    _$scrollControllerAtom.reportRead();
    return super.scrollController;
  }

  @override
  set scrollController(ScrollController value) {
    _$scrollControllerAtom.reportWrite(value, super.scrollController, () {
      super.scrollController = value;
    });
  }

  final _$loadPostsAsyncAction = AsyncAction('_PostsState.loadPosts');

  @override
  Future<void> loadPosts({int limit = 20, bool loadMore = false}) {
    return _$loadPostsAsyncAction
        .run(() => super.loadPosts(limit: limit, loadMore: loadMore));
  }

  final _$_PostsStateActionController = ActionController(name: '_PostsState');

  @override
  dynamic initController() {
    final _$actionInfo = _$_PostsStateActionController.startAction(
        name: '_PostsState.initController');
    try {
      return super.initController();
    } finally {
      _$_PostsStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addContent(Submission v) {
    final _$actionInfo = _$_PostsStateActionController.startAction(
        name: '_PostsState.addContent');
    try {
      return super.addContent(v);
    } finally {
      _$_PostsStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSorting(String v) {
    final _$actionInfo = _$_PostsStateActionController.startAction(
        name: '_PostsState.setSorting');
    try {
      return super.setSorting(v);
    } finally {
      _$_PostsStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(bool v) {
    final _$actionInfo = _$_PostsStateActionController.startAction(
        name: '_PostsState.setLoading');
    try {
      return super.setLoading(v);
    } finally {
      _$_PostsStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSubreddit(String v, [bool isPush]) {
    final _$actionInfo = _$_PostsStateActionController.startAction(
        name: '_PostsState.setSubreddit');
    try {
      return super.setSubreddit(v, isPush);
    } finally {
      _$_PostsStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic popSubreddit() {
    final _$actionInfo = _$_PostsStateActionController.startAction(
        name: '_PostsState.popSubreddit');
    try {
      return super.popSubreddit();
    } finally {
      _$_PostsStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
subreddits: ${subreddits},
lastSubreddits: ${lastSubreddits},
isLoading: ${isLoading},
sorting: ${sorting},
subreddit: ${subreddit},
scrollController: ${scrollController},
contents: ${contents},
authors: ${authors}
    ''';
  }
}
