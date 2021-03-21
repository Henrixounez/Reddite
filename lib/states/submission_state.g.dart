// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SubmissionState on _SubmissionState, Store {
  Computed<Submission> _$submitted_postComputed;

  @override
  Submission get submitted_post => (_$submitted_postComputed ??=
          Computed<Submission>(() => super.submitted_post,
              name: '_SubmissionState.submitted_post'))
      .value;

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

  final _$submitAsyncAction = AsyncAction('_SubmissionState.submit');

  @override
  Future<Submission> submit(String subreddit, String title,
      {String body = ""}) {
    return _$submitAsyncAction
        .run(() => super.submit(subreddit, title, body: body));
  }

  final _$_SubmissionStateActionController =
      ActionController(name: '_SubmissionState');

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
submitted_post: ${submitted_post}
    ''';
  }
}
