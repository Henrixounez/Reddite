import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/widgets/Scaffold.dart';
import 'package:reddite/utils/colors.dart';

class UploadScreen extends StatefulWidget {
  @override
  UploadScreenState createState() => UploadScreenState();
}

class UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return RedditeScaffold(
        body: Container(
            padding: EdgeInsets.all(50),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: darkGrey,
            ),
            child: null,
        )
    );
  }
}