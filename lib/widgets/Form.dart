import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddite/states/submission_state.dart';

import 'package:reddite/widgets/Input.dart';

import 'package:reddite/utils/colors.dart';

import '../utils/styles.dart';
import 'Button.dart';

class SubmissionForm extends StatefulWidget {
  @override
  SubmissionFormState createState() {
    return SubmissionFormState();
  }
}

class SubmissionFormState extends State<SubmissionForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text('Submit a post',style: fontMedium.copyWith(fontSize: 50)),
          this.titleInput(),
          this.bodyInput(),
          this.urlInput(),
          this.submitButton()
        ]
     )
    );
  }

  Widget titleInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 20.0),
      child: RedditeSubmissionInput(
        labelText: 'Title',
        validator: (value) {
          if (value.isEmpty) {
            return 'You need a title to create a post.';
          }
          return null;
        },
        controller: submissionStore.titleInputController,
      ),
    );
  }

  Widget bodyInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: RedditeSubmissionInput(
        labelText: 'Body',
        validator: (value) {
          if (value != "" && submissionStore.urlInputController.text != "") {
            return 'A self submission can\'t have an url !';
          }
          return null;
        },
        controller: submissionStore.bodyInputController,
      ),
    );
  }

  Widget urlInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: RedditeSubmissionInput(
        labelText: 'Url',
        validator: (value) {
          if (value != "" && submissionStore.bodyInputController.text != "") {
            return 'A url submission can\'t have a body !';
          }
          return null;
        },
        controller: submissionStore.urlInputController,
      ),
    );
  }

  Widget submitButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RedditeButton(
        buttonColor: colorTheme.primary,
        child: Icon(Icons.file_upload, 
          color: colorTheme.primaryBg, 
          size: 40
        ),
        onPressed: () {
          if (_formKey.currentState.validate() && !submissionStore.isSubmitting) {
            submissionStore.submit();
          }
        },
      ),
    );
  }
}