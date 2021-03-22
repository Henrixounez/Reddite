import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:reddite/widgets/Scaffold/Drawer.dart';
import 'package:reddite/widgets/Scaffold/Fab.dart';
import 'package:reddite/widgets/Scaffold/AppBar.dart';

// Reddite Scaffold
//
// Main Scaffold used in the App
// Can be customized to show or not the default Navbar or Appbar
// AppBar can also be customized with an other AppBar

class RedditeScaffold extends StatelessWidget{
  final Widget body;
  final bool showNavbar;
  final Widget customNavbar;
  final bool extendBodyBehindAppBar;
  final bool showFab;

  const RedditeScaffold({
    Key key,
    @required this.body,
    this.showNavbar = true,
    this.showFab = true,
    this.extendBodyBehindAppBar = false,
    this.customNavbar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        endDrawerEnableOpenDragGesture: false,
        appBar:
          customNavbar != null ? customNavbar :
          showNavbar ? PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: RedditeAppBar()
          ) : null,
        body: body,
        drawer: RedditeDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: showFab ? RedditeFab() : null,
      )
    );
  }
}
