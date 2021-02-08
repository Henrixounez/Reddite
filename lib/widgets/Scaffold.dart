import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RedditeScaffold extends StatelessWidget {
  const RedditeScaffold({
    Key key,
    this.body,
  }) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: this.body,
      )
    );
  }
}