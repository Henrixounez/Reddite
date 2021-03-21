import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:draw/draw.dart';

import 'package:reddite/states/submission_state.dart';

import 'package:reddite/utils/colors.dart';

import 'package:reddite/widgets/Scaffold.dart';

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
          body: Container(
            padding: EdgeInsets.all(50),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: colorTheme.secondaryBg,
            ),
            child: ListView(
              children: [],
            )
          )
        )
      );
    } else if (submissionStore.submitted_post != null) {
      // TODO: go to submitted post
      return null;
    } else {
      return RedditeScaffold(
        body: Center(
          child: Text('An error occured, please try again')
        )
      );
    }
  }
}