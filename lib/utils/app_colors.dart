import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color transparent = Colors.transparent; // transparentColor

  // Background
  static const Color backgroundLight = Color(0xFFF4F7FF); // lightBgColor
  static const Color backgroundDark = Color(0xFF000F30); // darkBgColor

  // Input
  static const Color inputDark = Color(0xFF001440); // darkInputColor

  // Primary
  static const Color primaryLight = Color(0xFF0E3A99); // mainLightColor
  static const Color primaryDark = Color(0xFF457AED); // mainDarkColor

  // Text
  static const Color textPrimaryLight = Color(0xFF1C1C1C); // blackColor
  static const Color textPrimaryDark = Color(0xFFFFFFFF); // whiteColor

  static const Color textSecondaryLight = Color(0xFF686868); // greyColor
  static const Color textSecondaryDark = Color(0xFFD6D6D6); // whiteDarkColor

  // Stroke
  static const Color strokeLight = Color(0xFFF0F0F0); // strokeWhiteColor
  static const Color strokeDark = Color(0xFF002D8F); // strokeDarkColor

  // States
  static const Color disabled = Color(0xFFB9B9B9); // disableColor / lightGreyColor
  static const Color error = Color(0xFFFF3232); // redColor
  static const Color success = Colors.green; // greenColor
}