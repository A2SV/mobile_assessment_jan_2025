import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/constants/app_colors.dart';
import 'package:mobile_assessment_jan_2025/constants/app_sizes.dart';

class CustomNavHeading extends StatelessWidget {
  CustomNavHeading(
      {super.key,
      this.fontSize,
      this.fontWeight,
      this.textOverFlow,
      this.fontStyle,
      required this.text});
  final String text;
  Color? fontColor;
  final fontSize;
  final fontWeight;
  final textOverFlow;
  final fontStyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: fontColor ?? primaryColor,
        fontSize: fontSize ?? Sizes.p20,
        fontWeight: fontWeight ?? FontWeight.bold,
        fontStyle: fontStyle,
        overflow: textOverFlow,
      ),
    );
  }
}
