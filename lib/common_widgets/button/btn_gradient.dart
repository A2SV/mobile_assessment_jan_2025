import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/common_widgets/text/custom_text.dart';
import 'package:mobile_assessment_jan_2025/constants/app_colors.dart';
import 'package:mobile_assessment_jan_2025/constants/app_sizes.dart';

class BtnGradient extends StatelessWidget {
  const BtnGradient({
    super.key,
    required this.text,
    this.fontColor,
    this.fontSize,
    this.color,
    this.borderRadius,
    required this.action,
  });
  final String text;
  final Color? fontColor;
  final double? fontSize;
  final Color? color;
  final double? borderRadius;
  final action;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(Sizes.p10),
        decoration: BoxDecoration(
            color: color ?? primaryColor,
            gradient: LinearGradient(
              colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? Sizes.p16),
            boxShadow: []),
        child: CustomText(
          text: text,
          fontColor: fontColor ?? Colors.white,
          fontSize: fontSize ?? Sizes.p16,
        ),
      ),
    );
  }
}
