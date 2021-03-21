import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:reddite/utils/colors.dart';

import 'package:flutter/widgets.dart';

class UserIcon extends StatelessWidget {

  final String iconUrl;

  UserIcon({
    @required this.iconUrl,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (iconUrl != null && iconUrl != '')
      return Image.network(
        iconUrl.replaceAll('&amp;', '&'),
        width: 30,
        height: 30,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null)
            return child;
          return SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            FeatherIcons.user,
            size: 30,
            color: colorTheme.secondaryText,
          );
        },
      );
    else {
      return SizedBox(
        width: 30,
        height: 30,
        child: Icon(
          FeatherIcons.box,
          size: 20,
          color: colorTheme.secondaryText,
        )
      );
    }
  }
}