import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddite/utils/colors.dart';

class RedditeLoginButton extends StatelessWidget {
  const RedditeLoginButton({
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
          color: colorTheme.primaryBg,
          width: 3,
          style: BorderStyle.solid
        ),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}

class RedditeButton extends StatelessWidget {

  final Widget child;
  final Function onPressed;
  final Function onLongPressed;
  final bool rounded;

  const RedditeButton({
    Key key,
    @required this.child,
    this.onPressed,
    this.onLongPressed,
    this.rounded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (
      Material(
        color: Colors.transparent,
        borderRadius: rounded == true ? BorderRadius.all(Radius.circular(100)) : null,
        child: InkWell(
          onLongPress: onLongPressed,
          onTap: onPressed,
          child: child
        )
      )
    );
  }
}