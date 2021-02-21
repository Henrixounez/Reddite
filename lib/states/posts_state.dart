import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:draw/draw.dart';
import 'package:reddite/states/auth.dart';

part 'posts_state.g.dart';

class PostsState = _PostsState with _$PostsState;

abstract class _PostsState with Store {
  bool _isInit = false;

  @action
  initController() {
    streamController.stream.listen((event) {
      Submission content = event;
      content.refreshComments();
      this.addContent(content);
      if (!_subreddits.containsKey(content.subreddit.path)) {
        content.subreddit.populate().then((value) => _subreddits[content.subreddit.path] = value);
      }
      // if (!_authors.containsKey(content.author)) {
      //   authStore.reddit
      //     .redditor(content.author)
      //     .populate()
      //     .then((value) {
      //       _authors[content.author] = value;
      //     });
      // }
    }, onDone: () {
      setLoading(false);
    }, onError: (error) {
      print(error);
    });
    _isInit = true;
  }

  StreamController<UserContent> streamController = StreamController.broadcast();

  @observable
  List<Submission> _contents = [];
  @observable
  Map<String, Redditor> _authors = {};
  @observable
  Map<String, Subreddit> _subreddits = {};
  @observable
  bool isLoading = false;
  @observable
  String sorting = "hot";
  @observable
  String subreddit = "all";

  @computed
  List<Submission> get contents => List.from(_contents);
  @computed
  Map<String, Redditor> get authors => _authors;
  @computed
  Map<String, Subreddit> get subreddits => _subreddits;

  @action
  addContent(Submission v) => this._contents.add(v);
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
  setSubreddit(String v) => this.subreddit = v;

  void loadPosts({
    int limit = 20,
    bool loadMore = false
  }) async {

    if (!_isInit)
      initController();
  
    setLoading(true);

    if (!loadMore) {
      _contents.clear();
      _subreddits.clear();
      _authors.clear();
    }

    String after = loadMore ? _contents.last.fullname : null;
    Stream<UserContent> stream;
    stream = getSortFunction(limit, after);
    await streamController.addStream(stream);
    setLoading(false);
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