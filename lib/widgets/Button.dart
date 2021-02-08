import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddite/utils/colors.dart';

class RedditeButton extends StatelessWidget {
  const RedditeButton({
    Key key,
    this.child,
    this.onPressed,
  }) : super(key: key);

  final Widget child;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15
        ),
        child: this.child
      ),
      onPressed: this.onPressed,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: white,
          width: 3,
          style: BorderStyle.solid
        ),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}