import 'package:mobx/mobx.dart';
import 'package:draw/draw.dart';
import 'package:reddite/states/auth.dart';

import 'auth.dart';

part 'submission_state.g.dart';

class SubmissionState = _SubmissionState with _$SubmissionState;

abstract class _SubmissionState with Store {

  @observable
  Submission _submitted_post = null;

  @computed
  Submission get submitted_post => _submitted_post;

  @action
  unload() {
    this._submitted_post = null;
  }

  @action
  Future<Submission> submit(String subreddit, String title, { String body = "" } ) async {
    try {
      Submission new_submission = await authStore.reddit.subreddit(subreddit).submit(title, selftext: body);
      this._submitted_post = submitted_post;
      return new_submission;
    } catch (e) {
      return null;
    }
  }
}

final SubmissionStore = SubmissionState();
