import 'package:flutter/material.dart';

class AppSizes {
  static late double screenWidth;
  static late double screenHeight;
  static late double blockWidth;
  static late double blockHeight;
  static late double textScaleFactor;

  static void init(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;
    textScaleFactor = mediaQueryData.textScaleFactor;
  }

  /// Text sizes (scalable)
  static double get textXs => blockWidth * 3;
  static double get textSm => blockWidth * 3.5;
  static double get textMd => blockWidth * 4.5;
  static double get textLg => blockWidth * 6;
  static double get textXl => blockWidth * 7.5;

  /// Padding / Margin
  static double get paddingXs => blockWidth * 2;
  static double get paddingSm => blockWidth * 3;
  static double get paddingMd => blockWidth * 4;
  static double get paddingLg => blockWidth * 6;
  static double get paddingXl => blockWidth * 8;

  /// Border radius values (responsive)
  static double get borderRadiusSm => blockWidth * 2;
  static double get borderRadiusMd => blockWidth * 3;
  static double get borderRadiusLg => blockWidth * 5;

  /// Shadow blur radius
  static double get shadowBlurRadius => blockWidth * 2;

  /// Shadow offset Y
  static double get shadowOffsetY => blockHeight * 0.5;
}
