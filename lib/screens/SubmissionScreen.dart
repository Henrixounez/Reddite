import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:reddite/states/submission_state.dart';

import 'package:reddite/utils/colors.dart';
import 'package:reddite/widgets/Form.dart';

import 'package:reddite/widgets/Scaffold/Scaffold.dart';

// Submission Screen
//
// Shows the Form to create a new Submission in the current focused subreddit
// It can be a Text or a URL Submission
// (Image not handled by DRAW API)

class SubmissionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!submissionStore.submitted) {
      return WillPopScope(
        onWillPop: () async {
          submissionStore.unload();
          return true;
        },
        child: RedditeScaffold(
          showFab: false,
          customNavbar: AppBar(
            backgroundColor: colorTheme.primary,
            shadowColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Container(
            color: colorTheme.primaryBg,
            child: SubmissionForm()
          )
        )
      );
    } else {
      return RedditeScaffold(
        body: Center(
          child: Text('An error occured, please try again')
        )
      );
    }
  }
}