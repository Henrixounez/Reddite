

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/route_manager.dart';
import 'package:reddite/utils/routes.dart';

class RedditeFab extends StatefulWidget {
  @override
  _RedditeFabState createState() => _RedditeFabState();
}

class _RedditeFabState extends State<RedditeFab> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _secondaryNavigationAnimation;
  Animation _rotationAnimation;

  double _degreesToRadiant(double degree) {
    const double unitRadiant = 57.295779513;
    return degree / unitRadiant;
  }

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    _secondaryNavigationAnimation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _rotationAnimation = Tween<double>(begin: 0.0, end: 45.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    super.initState();
    _animationController.addListener(() {setState(() {});});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(250, 500),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomRight,
        children: <Widget>[
          Positioned(
            bottom: 10,
            right: 0,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                _secondaryNavigationAnimation.value != 0 ?
                Transform.translate(
                  offset: Offset.fromDirection(_degreesToRadiant(270), _secondaryNavigationAnimation.value * 160),
                  child: Opacity(
                    opacity: _secondaryNavigationAnimation.value,
                    child: FloatingActionButton(
                      heroTag: 'post-text',
                      tooltip: 'Post a text',
                      backgroundColor: Colors.red,
                      onPressed: () => Get.toNamed(submissionRoute, parameters: {"type": "text"}),
                      child: Icon(
                        FeatherIcons.type,
                        color: Colors.white,
                      ),
                    )
                  ),
                ) : SizedBox.shrink(),
                _secondaryNavigationAnimation.value != 0 ?
                Transform.translate(
                  offset: Offset.fromDirection(_degreesToRadiant(270), _secondaryNavigationAnimation.value * 80),
                  child: Opacity(
                    opacity: _secondaryNavigationAnimation.value,
                    child: FloatingActionButton(
                      heroTag: 'post-link',
                      tooltip: 'Post a link',
                      backgroundColor: Color(0xfffac62c),
                      onPressed: () => Get.toNamed(submissionRoute, parameters: {"type": "url"}),
                      child: Icon(
                        FeatherIcons.link,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ) : SizedBox.shrink(),
                Transform(
                  transform: Matrix4.rotationZ(_degreesToRadiant(_rotationAnimation.value)),
                  alignment: Alignment.center,
                  child: FloatingActionButton(
                    heroTag: 'post-open-close',
                    backgroundColor: Color(0xfff38f26),
                    onPressed: () => {
                      if (_animationController.isCompleted) { _animationController.reverse() }
                      else { _animationController.forward() }
                    },
                    child: Icon(
                      FeatherIcons.plus,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]
            )
          )
        ]
      )
    );
  }
}