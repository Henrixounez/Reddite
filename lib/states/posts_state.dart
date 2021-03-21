import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mobx/mobx.dart';
import 'package:draw/draw.dart';
import 'package:reddite/states/auth.dart';
import 'package:reddite/states/global_state.dart';

part 'posts_state.g.dart';

class PostsState = _PostsState with _$PostsState;

abstract class _PostsState with Store {
  bool _isInit = false;

  @action
  initController() {
    streamController.stream.listen((event) async {
      if (event == null)
        return;
      if (event is Submission) {
        Submission content = event;
        content.refreshComments();
        this.addContent(content);
        if (!subreddits.containsKey(content.subreddit.path)) {
          this.addSubreddit(content);
        }
      } else if (event is Comment) {
        Comment content = event;
        this.addContent(content);
      }
    }, onDone: () {
      setLoading(false);
    }, onError: (error) {
      print(error);
    });
    _isInit = true;
  }

  StreamController<UserContent> streamController = StreamController.broadcast();

  @observable
  List<UserContent> _contents = [];
  @observable
  Map<String, Redditor> _authors = {};
  @observable
  ObservableMap<String, Subreddit> subreddits = ObservableMap<String, Subreddit>.of({});
  @observable
  List<String> lastSubreddits = [];
  @observable
  bool isLoading = false;
  @observable
  String sorting = "hot";
  @observable
  String subreddit = "all";
  @observable
  ScrollController scrollController = ScrollController();

  @computed
  List<UserContent> get contents => List.from(_contents);
  @computed
  Map<String, Redditor> get authors => _authors;

  Future<void> addSubreddit(Submission content) async {
    Subreddit sub = await content.subreddit.populate();
    this.subreddits.addAll({content.subreddit.path: sub});
  }
  @action
  addContent(UserContent v) => this._contents.add(v);
  @action
  setSorting(String v) {
    bool shouldRefresh = this.sorting != v;
    this.sorting = v.toLowerCase();

    if (shouldRefresh)
      loadPosts();
  }
  @action
  setLoading(bool v) => this.isLoading = v;
  @action
  setSubreddit(String v, [bool isPush]) {
    if (isPush ?? false)
      this.lastSubreddits.add(this.subreddit);
    this.subreddit = v;
    globalStore.topInputController.text = this.subreddit;
  }
  @action
  popSubreddit() {
    this.subreddit = this.lastSubreddits.length > 0 ? this.lastSubreddits.removeLast() : 'all';
    globalStore.topInputController.text = this.lastSubreddits.length > 0 ? this.subreddit : "";
  }

  initLoading(bool loadMore) {
    if (!_isInit)
      initController();
  
    setLoading(true);

    if (!loadMore) {
      _contents.clear();
      subreddits.clear();
      _authors.clear();
      streamController.add(null);
    }
  }

  String getFullName(UserContent content) {
    if (content is Submission) {
      return content.fullname;
    } else if (content is Comment) {
      return content.fullname;
    } else {
      return '';
    }
  }

  @action
  Future<void> loadProfilePosts({
    int limit = 20,
    bool loadMore = false
  }) async {
    try {
      initLoading(loadMore);

      String after = loadMore ? getFullName(_contents.last) : null;
      Stream<UserContent> stream;
      stream = authStore.me.submissions.newest(
        limit: limit,
        after: after,
      );
      await streamController.addStream(stream);
      setLoading(false);

    } catch (error) {
      print(error);
    }
  }

  @action
  Future<void> loadPosts({
    int limit = 20,
    bool loadMore = false
  }) async {

    try {
      initLoading(loadMore);

      String after = loadMore ? getFullName(_contents.last) : null;
      Stream<UserContent> stream;
      stream = getSortFunction(limit, after);
      await streamController.addStream(stream);
      setLoading(false);
    } catch (error) {
      print(error);
      this.popSubreddit();
      this.loadPosts();
    }
  }

  Stream<UserContent> getSortFunction(int limit, String after) {
    switch (this.sorting) {
      case 'controversial':
        return authStore.reddit.subreddit(subreddit).controversial(
          limit: limit,
          after: after,
        );
      case 'hot':
        return authStore.reddit.subreddit(subreddit).hot(
          limit: limit,
          after: after,
        );
      case 'newest':
        return authStore.reddit.subreddit(subreddit).newest(
          limit: limit,
          after: after,
        );
      case 'top':
        return authStore.reddit.subreddit(subreddit).top(
          limit: limit,
          after: after,
        );
      case 'rising':
        return authStore.reddit.subreddit(subreddit).rising(
          limit: limit,
          after: after,
        );
      default:
        return authStore.reddit.subreddit(subreddit).top(
          limit: limit,
          after: after,
        );
    }
  }
}

final postsStore = PostsState();