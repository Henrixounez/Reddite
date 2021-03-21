import 'package:mobx/mobx.dart';
import 'package:draw/draw.dart';
import 'package:reddite/states/auth.dart';

import 'auth.dart';

part 'submission_state.g.dart';

class SubmissionState = _SubmissionState with _$SubmissionState;

abstract class _SubmissionState with Store {
  @observable
  bool _submitted = false;

  @observable
  Submission _submitted_post = null;

  @computed
  bool get submitted => _submitted;

  @computed
  Submission get submitted_post => _submitted_post;

  @action
  setSubmitState(bool submitState) {
    this._submitted = submitState;
  }

  @action
  unload() {
    this._submitted_post = null;
    this._submitted = false;
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

final submissionStore = SubmissionState();
