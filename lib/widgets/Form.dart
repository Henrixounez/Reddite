import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';

import 'package:reddite/states/submission_state.dart';
import 'package:reddite/widgets/Input.dart';
import 'package:reddite/widgets/Button.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/styles.dart';


// Submission Form
//
// Display and Manage inputs for the Submission Screen's Form
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
    print(Get.parameters['type']);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          this.titleInput(),
          if (Get.parameters['type'] == 'text')
            this.bodyInput(),
          if (Get.parameters['type'] == 'url')
            this.urlInput(),
          this.submitButton()
        ]
     )
    );
  }

  // Input for the Title of the Submission
  Widget titleInput() {
    return Container(
      color: colorTheme.ternaryBg,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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

  // Multiline Input for the Submission (If is Text)
  Widget bodyInput() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: RedditeSubmissionInput(
          multiline: true,
          labelText: 'Body',
          validator: (value) {
            if (value != "" && submissionStore.urlInputController.text != "") {
              return 'A self submission can\'t have an url !';
            }
            return null;
          },
          controller: submissionStore.bodyInputController,
        ),
      )
    );
  }

  // Single line Input for the Submission (If is URL)
  Widget urlInput() {
    return Expanded(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
      )
    );
  }

  // Button to submit Submission and send it to Reddit
  Widget submitButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: RedditeButton(
        onPressed: () {
          if (_formKey.currentState.validate() && !submissionStore.isSubmitting)
            submissionStore.submit(
              Get.parameters['type'] == 'text'
            );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
          decoration: BoxDecoration(
            color: colorTheme.primary,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Text('Post', style: fontMedium.copyWith(color: colorTheme.primaryBg, fontSize: 15),),
        )
      )
    );
  }
}