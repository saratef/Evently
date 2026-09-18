import 'package:evently/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef onChanged= void Function(String)?;
typedef onValidator= String Function(String)?;
class CustomTextFormField extends StatelessWidget {
  final double? radius;
  final Color borderColor;
  final Color? fillColor;
  final bool? filled;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final onChanged;
  final onValidator;
  final TextEditingController? controller;
  final  TextInputType textInputType;
  final bool obscureText;

  CustomTextFormField({
    super.key,
    this.radius,
    required this.borderColor,
    this.filled,
    this.fillColor,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.onChanged,
    this.onValidator,
    this.controller,
    this.textInputType=TextInputType.text,
    this.obscureText=false

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // style:Theme.of(context).textTheme.bodyLarge,
      onChanged: onChanged,
      validator: onValidator,
      controller:controller ,
      obscureText: obscureText,
      maxLines: maxLines,
      keyboardType: textInputType,
      decoration: InputDecoration(
        enabledBorder: _builtOutLineInputBorder(radius ?? 16, borderColor),
        focusedBorder: _builtOutLineInputBorder(radius ?? 16, borderColor),
        errorBorder: _builtOutLineInputBorder(radius ?? 16, AppColors.error),
        focusedErrorBorder: _builtOutLineInputBorder(
          radius ?? 16,
          AppColors.error,
        ),

        filled: filled,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

      ),
    );
  }

  OutlineInputBorder _builtOutLineInputBorder(
    double radius,
    Color borderColor,
  ) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(width: 2, color: borderColor),
    );
  }
}
