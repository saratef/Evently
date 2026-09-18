import 'package:evently/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color? borderColor;
  final double? verticalPadding;
  final double? borderRadius;
  CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.backgroundColor,
    this.verticalPadding,
    this.borderRadius,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
          side: BorderSide(color: borderColor ?? AppColors.transparent),
        ),
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 0),

        backgroundColor: backgroundColor,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
