import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/styles.dart';

class RedditeTopInput extends StatefulWidget {
  final String hintText;
  final Function onChange;
  final Function onSubmit;

  const RedditeTopInput({
    Key key,
    this.hintText,
    @required this.onChange,
    @required this.onSubmit,
  });

  _RedditeTopInput createState() => _RedditeTopInput();
}

class _RedditeTopInput extends State<RedditeTopInput> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(100))
        ),
        height: 32,
        padding: EdgeInsets.only(left: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  fillColor: Colors.white,
                  hintStyle: fontBook.copyWith(color: lightText),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  suffix: SizedBox(height: 20)
                ),
                cursorColor: lightText,
                style: fontBook.copyWith(color: darkGrey),
                onChanged: (String value) { widget.onChange(value); },
                onSubmitted: (String text) { widget.onSubmit(text); },
              ),
            ),
            IconButton(
              icon: Icon(
                FeatherIcons.search,
                color: redditOrange,
                size: 16
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                widget.onSubmit(controller.text);
              },
            ),
          ]
        )
      )
    );
  }
}