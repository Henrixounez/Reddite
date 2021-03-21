import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddite/widgets/Scaffold.dart';
import 'package:reddite/utils/colors.dart';

import '../utils/colors.dart';

class SubmissionScreen extends StatefulWidget {
  @override
  SubmissionScreenState createState() => SubmissionScreenState();
}

class SubmissionScreenState extends State<SubmissionScreen> {
  @override
  Widget build(BuildContext context) {
    return RedditeScaffold(
        body: Container(
            padding: EdgeInsets.all(50),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: colorTheme.secondaryBg,
            ),
            child: null,
        )
    );
  }
}