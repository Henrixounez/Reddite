import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddite/widgets/Scaffold.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RedditeScaffold(
      body: Text('Home screen'),
    );
  }
}