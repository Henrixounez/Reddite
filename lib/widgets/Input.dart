import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:reddite/states/global_state.dart';
import 'package:reddite/utils/colors.dart';
import 'package:reddite/utils/styles.dart';

class RedditeTopInput extends StatelessWidget {
  final String hintText;
  final Function onChange;
  final Function onSubmit;

  const RedditeTopInput({
    Key key,
    this.hintText,
    @required this.onChange,
    @required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: colorTheme.primaryBg,
          borderRadius: BorderRadius.all(Radius.circular(100))
        ),
        height: 32,
        padding: EdgeInsets.only(left: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: TextField(
                controller: globalStore.topInputController,
                decoration: InputDecoration(
                  hintText: hintText,
                  fillColor: colorTheme.primaryBg,
                  hintStyle: fontBook.copyWith(color: colorTheme.primaryText),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  suffix: SizedBox(height: 20)
                ),
                cursorColor: colorTheme.primaryText,
                style: fontBook.copyWith(color: colorTheme.secondaryText),
                onChanged: (String value) { onChange(value); },
                onSubmitted: (String text) { onSubmit(text); },
              ),
            ),
            IconButton(
              icon: Icon(
                FeatherIcons.search,
                color: colorTheme.primary,
                size: 16
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                onSubmit(globalStore.topInputController.text);
              },
            ),
          ]
        )
      )
    );
  }
}

class RedditeSubmissionInput extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Function validator;
  final TextEditingController controller;

  const RedditeSubmissionInput({
    Key key,
    this.hintText,
    @required this.labelText,
    @required this.controller,
    @required this.validator,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: colorTheme.primaryBg,
          borderRadius: BorderRadius.all(Radius.circular(100))
        ),
        height: 50,
        padding: EdgeInsets.only(left: 20),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
              fillColor: colorTheme.primaryBg,
              hintStyle: fontBook.copyWith(color: colorTheme.primaryText),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              suffix: SizedBox(height: 20)
            ),
          cursorColor: colorTheme.primaryText,
          style: fontBook.copyWith(color: colorTheme.secondaryText),
          validator: validator
        ),
    );
  }
}