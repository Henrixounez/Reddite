import 'package:flutter/material.dart';

// Color Palette
// The colors can be changed easily here,
// and is reflected everywhere in the app
class ColorTheme {
  ColorTheme({
    @required this.primary,
    @required this.secondary,
    @required this.primaryBg,
    @required this.secondaryBg,
    @required this.ternaryBg,
    @required this.primaryText,
    @required this.secondaryText,
    @required this.upvote,
    @required this.downvote,
    @required this.icon,
  });

  final Color primary;
  final Color secondary;
  final Color primaryBg;
  final Color secondaryBg;
  final Color ternaryBg;
  final Color primaryText;
  final Color secondaryText;
  final Color upvote;
  final Color downvote;
  final Color icon;
}

// Main Color Palette
ColorTheme colorTheme = ColorTheme(
  primary: Color(0xFFFF5700), // Reddit Orange
  secondary: Color(0xFFFF9100), // Light Orange
  primaryBg: Color(0xFFFFFFFF), // White
  secondaryBg: Color(0xFF303030), // Dark Grey
  ternaryBg: Color(0xFFF8F8F8), // Light Grey
  primaryText: Color(0xFFC2C2C2), // Light Text
  secondaryText: Color(0xFF303030), // Dark Grey
  upvote: Color(0xffFF8B60), // Upvote Orange
  downvote: Color(0xFF9494FF), // Downvote Blue
  icon: Color(0xFFFFFFFF), // White
);