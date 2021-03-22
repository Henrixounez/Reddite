// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SubmissionState on _SubmissionState, Store {
  Computed<bool> _$submittedComputed;

  @override
  bool get submitted =>
      (_$submittedComputed ??= Computed<bool>(() => super.submitted,
              name: '_SubmissionState.submitted'))
          .value;
  Computed<Submission> _$submitted_postComputed;

  @override
  Submission get submitted_post => (_$submitted_postComputed ??=
          Computed<Submission>(() => super.submitted_post,
              name: '_SubmissionState.submitted_post'))
      .value;

  final _$_submittedAtom = Atom(name: '_SubmissionState._submitted');

  @override
  bool get _submitted {
    _$_submittedAtom.reportRead();
    return super._submitted;
  }

  @override
  set _submitted(bool value) {
    _$_submittedAtom.reportWrite(value, super._submitted, () {
      super._submitted = value;
    });
  }

  final _$_submitted_postAtom = Atom(name: '_SubmissionState._submitted_post');

  @override
  Submission get _submitted_post {
    _$_submitted_postAtom.reportRead();
    return super._submitted_post;
  }

  @override
  set _submitted_post(Submission value) {
    _$_submitted_postAtom.reportWrite(value, super._submitted_post, () {
      super._submitted_post = value;
    });
  }

  final _$titleInputControllerAtom =
      Atom(name: '_SubmissionState.titleInputController');

  @override
  TextEditingController get titleInputController {
    _$titleInputControllerAtom.reportRead();
    return super.titleInputController;
  }

  @override
  set titleInputController(TextEditingController value) {
    _$titleInputControllerAtom.reportWrite(value, super.titleInputController,
        () {
      super.titleInputController = value;
    });
  }

  final _$bodyInputControllerAtom =
      Atom(name: '_SubmissionState.bodyInputController');

  @override
  TextEditingController get bodyInputController {
    _$bodyInputControllerAtom.reportRead();
    return super.bodyInputController;
  }

  @override
  set bodyInputController(TextEditingController value) {
    _$bodyInputControllerAtom.reportWrite(value, super.bodyInputController, () {
      super.bodyInputController = value;
    });
  }

  final _$urlInputControllerAtom =
      Atom(name: '_SubmissionState.urlInputController');

  @override
  TextEditingController get urlInputController {
    _$urlInputControllerAtom.reportRead();
    return super.urlInputController;
  }

  @override
  set urlInputController(TextEditingController value) {
    _$urlInputControllerAtom.reportWrite(value, super.urlInputController, () {
      super.urlInputController = value;
    });
  }

  final _$isSubmittingAtom = Atom(name: '_SubmissionState.isSubmitting');

  @override
  bool get isSubmitting {
    _$isSubmittingAtom.reportRead();
    return super.isSubmitting;
  }

  @override
  set isSubmitting(bool value) {
    _$isSubmittingAtom.reportWrite(value, super.isSubmitting, () {
      super.isSubmitting = value;
    });
  }

  final _$submitAsyncAction = AsyncAction('_SubmissionState.submit');

  @override
  Future<Submission> submit(bool isSelf) {
    return _$submitAsyncAction.run(() => super.submit(isSelf));
  }

  final _$_SubmissionStateActionController =
      ActionController(name: '_SubmissionState');

  @override
  dynamic setIsSubmitting(bool v) {
    final _$actionInfo = _$_SubmissionStateActionController.startAction(
        name: '_SubmissionState.setIsSubmitting');
    try {
      return super.setIsSubmitting(v);
    } finally {
      _$_SubmissionStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSubmitState(bool submitState) {
    final _$actionInfo = _$_SubmissionStateActionController.startAction(
        name: '_SubmissionState.setSubmitState');
    try {
      return super.setSubmitState(submitState);
    } finally {
      _$_SubmissionStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic unload() {
    final _$actionInfo = _$_SubmissionStateActionController.startAction(
        name: '_SubmissionState.unload');
    try {
      return super.unload();
    } finally {
      _$_SubmissionStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
titleInputController: ${titleInputController},
bodyInputController: ${bodyInputController},
urlInputController: ${urlInputController},
isSubmitting: ${isSubmitting},
submitted: ${submitted},
submitted_post: ${submitted_post}
    ''';
  }
}
