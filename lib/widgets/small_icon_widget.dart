import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/app/common/app_text_style.dart';

import '../app/common/ui_helpers.dart';

class SmallIconWidget extends StatelessWidget {
  const SmallIconWidget({
    super.key,
    required this.name,
    required this.selected,
    required this.onTap,
    this.icon,
    this.color,
    this.txtColor,
    this.textStyle,
    this.roundness,
    this.hPadding,
    this.vPadding,
  });
  final String name;
  final bool selected;
  final VoidCallback onTap;
  final Widget? icon;
  final Color? color;
  final Color? txtColor;
  final TextStyle? textStyle;
  final double? roundness;
  final double? hPadding;
  final double? vPadding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: hPadding ?? mediumSize,
          vertical: vPadding ?? smallSize,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: color ?? Colors.black,
            width: selected ? 0 : 1.5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(roundness ?? 25),
          ),
          color: selected ? color ?? Colors.black : Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              style: textStyle ??
                  regular.copyWith(
                    color: txtColor ?? (selected ? Colors.white : Colors.black),
                  ),
            ),
            if (icon != null) ...[
              icon!,
            ],
          ],
        ),
      ),
    );
  }
}
