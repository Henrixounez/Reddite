import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:draw/draw.dart';
import 'package:reddite/states/auth.dart';
import 'package:get/route_manager.dart';

import 'package:reddite/utils/routes.dart';
import 'package:reddite/states/focus_post_state.dart';
import 'package:reddite/states/posts_state.dart';

import 'auth.dart';

part 'submission_state.g.dart';

// Submission State
//
// Hold informations for the Form to create a new Post
// and handles the submission process

class SubmissionState = _SubmissionState with _$SubmissionState;

abstract class _SubmissionState with Store {
  @observable
  bool _submitted = false;

  @observable
  Submission _submitted_post = null;

  @observable
  TextEditingController titleInputController = TextEditingController();

  @observable
  TextEditingController bodyInputController = TextEditingController();

  @observable
  TextEditingController urlInputController = TextEditingController();
  
  @observable
  bool isSubmitting = false;

  @computed
  bool get submitted => _submitted;

  @computed
  Submission get submitted_post => _submitted_post;

  @action
  setIsSubmitting(bool v) => this.isSubmitting = v;

  @action
  setSubmitState(bool submitState) {
    this._submitted = submitState;
  }

  // Clear all data from the form and submission
  @action
  unload() {
    this._submitted_post = null;
    this._submitted = false;
    this.isSubmitting = false;
    this.titleInputController.clear();
    this.bodyInputController.clear();
    this.urlInputController.clear();
  }

  // Submit a Post to the currently focused subreddit
  // isSelf defines if the post is a Text or URL type
  // Sends the post to Reddit via DRAW, then refreshes the subreddit
  // and redirect to focus the newly created Post 
  @action
  Future<Submission> submit(bool isSelf) async {
    try {
      setIsSubmitting(true);
      Subreddit subreddit = await authStore.reddit.subreddit(postsStore.subreddit).populate();
      Submission result = isSelf ? (
        await subreddit.submit(
          titleInputController.text,
          selftext: bodyInputController.text
        )
      ) : (
        await subreddit.submit(
          titleInputController.text,
          url: urlInputController.text
        )
      );
      this._submitted_post = result;
      // This is needed because DRAW is kinda broken and result from 'submit' are not populated
      // Without querying the submission, Post widget will broke.
      Submission new_submission = await authStore.reddit.submission(url: result.url).populate();
      setIsSubmitting(false);
      focusPostStore.setPost(new_submission);
      this.unload();
      Get.offAndToNamed(postRoute);
      return new_submission;
    } catch (e) {
      setIsSubmitting(false);
      print("ERROR: \n");
      print(e);
      return null;
    }
  }
}

final submissionStore = SubmissionState();
