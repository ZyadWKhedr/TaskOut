import 'package:flutter/material.dart';
import '../utils/app_sizes.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool underline;
  final Color? underlineColor;
  final double underlineThickness;
  final TextDecorationStyle underlineStyle;

  const CustomText(
    this.text, {
    Key? key,
    this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.underline = false,
    this.underlineColor,
    this.underlineThickness = 1.0,
    this.underlineStyle = TextDecorationStyle.solid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure AppSizes is initialized
    AppSizes.init(context);

    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize ?? AppSizes.textMd,
        fontWeight: fontWeight,
        color: color ?? Colors.black,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
        decorationColor: underlineColor ?? color ?? Colors.black,
        decorationThickness: underlineThickness,
        decorationStyle: underlineStyle,
      ),
    );
  }
}
