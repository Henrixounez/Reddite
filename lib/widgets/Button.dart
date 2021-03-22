import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddite/utils/colors.dart';

// Big Button used for the Login Page
//
// Transparent Button with big font size, transparent background
// and rounded thick white border

class RedditeLoginButton extends StatelessWidget {

  final Widget child;
  final Function onPressed;

  const RedditeLoginButton({
    Key key,
    this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15
        ),
        child: this.child
      ),
      onPressed: this.onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          )
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: colorTheme.primaryBg,
            width: 3,
            style: BorderStyle.solid
          )
        ),
      ),
    );
  }
}

// Reddite Button
//
// Wrapper for all Buttons to show ripple and handle presses
// Can be made rounded and have the color changed
// Handle press or longPress
class RedditeButton extends StatelessWidget {

  final Widget child;
  final Function onPressed;
  final Function onLongPressed;
  final Color buttonColor;
  final bool rounded;

  const RedditeButton({
    Key key,
    @required this.child,
    this.onPressed,
    this.onLongPressed,
    this.buttonColor = null,
    this.rounded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (
      Material(
        color: buttonColor ?? Colors.transparent,
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