import 'package:mobx/mobx.dart';
import 'package:draw/draw.dart';
import 'package:reddite/states/auth.dart';

part 'focus_post_state.g.dart';

// Focus Post State
//
// Holds information about the currently focused post
// (When a post is clicked)

class FocusPostState = _FocusPostState with _$FocusPostState;

abstract class _FocusPostState with Store {
  @observable
  Submission _post;
  @observable
  Map<String, Redditor> _authors = {};

  @computed
  Submission get post => _post;
  @computed
  Map<String, Redditor> get authors => _authors;

  // Set focused post (When clicking on it from subreddit view)
  @action
  setPost(Submission v) {
    this._post = v;
  }

  // Unload current post, clear any data
  @action
  unload() {
    this._post = null;
    this._authors.clear();
  }

  // Load author of post or replies
  @action
  Future<Redditor> loadAuthor(String v) async {
    try {
      Redditor newAuthor = await authStore.reddit.redditor(v).populate();
      this.authors[v] = newAuthor;
      return newAuthor;
    } catch (e) {
      return null;
    }
  }
}

final focusPostStore = FocusPostState();
