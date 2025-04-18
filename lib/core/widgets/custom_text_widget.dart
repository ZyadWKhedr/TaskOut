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

  const CustomText(
    this.text, {
    Key? key,
    this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
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
      ),
    );
  }
}
