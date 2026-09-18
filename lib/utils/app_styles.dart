import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppStyles {
  AppStyles._();
  static TextStyle semi20Black = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryLight,
  );

  static TextStyle semi16MainLightColor = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryLight,
  );

  static TextStyle semi16MainDark = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDark,
  );

  static TextStyle regular12MainLightColor = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryLight,
  );

  static TextStyle regular12GreyColor = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondaryLight,
  );

  static TextStyle medium14Black = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryLight,
  );

  static TextStyle regular14Grey = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondaryLight,
  );

  static TextStyle regular14MainLightColor = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryLight,
  );

  static TextStyle semi14MainLightColor = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryLight,
  );
  static TextStyle semi14White = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle medium16Black = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryLight,
  );

  static TextStyle medium16MainColor = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryLight,
  );

  static TextStyle medium18Black = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryLight,
  );

  static TextStyle medium18MainColor = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryLight,
  );

  static TextStyle medium20BlackColor = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryLight,
  );

  static TextStyle semi24MainLightColor = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryLight,
  );

  static TextStyle regular12MainDarkColor = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryDark,
  );

  static TextStyle regular12WhiteDarkColor = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondaryDark,
  );

  static TextStyle medium14White = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle regular14WhiteDark = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondaryDark,
  );

  static TextStyle regular14MainDarkColor = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryDark,
  );

  static TextStyle semi14MainDarkColor = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDark,
  );

  static TextStyle underlineSemi14MainDarkColor = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDark,
    decoration: TextDecoration.underline,
    decorationThickness: 1.7,
    decorationColor: AppColors.primaryDark,
  );
  static TextStyle underlineSemi14MainLightColor = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryLight,
    decoration: TextDecoration.underline,
    decorationThickness: 1.7,
    decorationColor: AppColors.primaryDark,
  );

  static TextStyle medium16White = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle medium16MainDarkColor = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryDark,
  );

  static TextStyle medium18White = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle medium18MainDarkColor = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryDark,
  );

  static TextStyle medium20White = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle semi20White = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle semi24MainDarkColor = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDark,
  );
}




// import 'dart:ui';
//
// import 'package:flutter/src/painting/text_style.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'app_colors.dart';
//
// class AppStyles {
//
//   AppStyles._();
//
//
//   static bool isArabic = false;
//
//   static TextStyle _font({
//     required double fontSize,
//     required FontWeight fontWeight,
//     required Color color,
//   }) {
//     return isArabic
//         ? GoogleFonts.tajawal(
//       fontSize: fontSize,
//       fontWeight: fontWeight,
//       color: color,
//     )
//         : GoogleFonts.poppins(
//       fontSize: fontSize,
//       fontWeight: fontWeight,
//       color: color,
//     );
//   }
//
//   static TextStyle get semi20Black => _font(
//     fontSize: 20,
//     fontWeight: FontWeight.w700,
//     color: AppColors.textPrimaryLight,
//   );
//
//   static TextStyle get semi16MainLightColor => _font(
//     fontSize: 16,
//     fontWeight: FontWeight.w700,
//     color: AppColors.primaryLight,
//   );
//
//   static TextStyle get semi16MainDark => _font(
//     fontSize: 16,
//     fontWeight: FontWeight.w700,
//     color: AppColors.primaryDark,
//   );
//
//   static TextStyle get regular12MainLightColor => _font(
//     fontSize: 12,
//     fontWeight: FontWeight.w400,
//     color: AppColors.primaryLight,
//   );
//
//   static TextStyle get regular12GreyColor => _font(
//     fontSize: 12,
//     fontWeight: FontWeight.w400,
//     color: AppColors.textSecondaryLight,
//   );
//
//   static TextStyle get medium14Black => _font(
//     fontSize: 14,
//     fontWeight: FontWeight.w500,
//     color: AppColors.textPrimaryLight,
//   );
//
//   static TextStyle get regular14Grey => _font(
//     fontSize: 14,
//     fontWeight: FontWeight.w400,
//     color: AppColors.textSecondaryLight,
//   );
//
//   static TextStyle get regular14MainLightColor => _font(
//     fontSize: 14,
//     fontWeight: FontWeight.w400,
//     color: AppColors.primaryLight,
//   );
//
//   static TextStyle get semi14MainLightColor => _font(
//     fontSize: 14,
//     fontWeight: FontWeight.w700,
//     color: AppColors.primaryLight,
//   );
//
//   static TextStyle get medium16Black => _font(
//     fontSize: 16,
//     fontWeight: FontWeight.w500,
//     color: AppColors.textPrimaryLight,
//   );
//
//   static TextStyle get medium16MainColor => _font(
//     fontSize: 16,
//     fontWeight: FontWeight.w500,
//     color: AppColors.primaryLight,
//   );
//
//   static TextStyle get medium18Black => _font(
//     fontSize: 18,
//     fontWeight: FontWeight.w500,
//     color: AppColors.textPrimaryLight,
//   );
//
//   static TextStyle get medium18MainColor => _font(
//     fontSize: 18,
//     fontWeight: FontWeight.w500,
//     color: AppColors.primaryLight,
//   );
//
//   static TextStyle get medium20BlackColor => _font(
//     fontSize: 20,
//     fontWeight: FontWeight.w500,
//     color: AppColors.textPrimaryLight,
//   );
//
//   static TextStyle get semi24MainLightColor => _font(
//     fontSize: 24,
//     fontWeight: FontWeight.w700,
//     color: AppColors.primaryLight,
//   );
//
//   static TextStyle get regular12MainDarkColor => _font(
//     fontSize: 12,
//     fontWeight: FontWeight.w400,
//     color: AppColors.primaryDark,
//   );
//
//   static TextStyle get regular12WhiteDarkColor => _font(
//     fontSize: 12,
//     fontWeight: FontWeight.w400,
//     color: AppColors.textSecondaryDark,
//   );
//
//   static TextStyle get medium14White => _font(
//     fontSize: 14,
//     fontWeight: FontWeight.w500,
//     color: AppColors.textPrimaryDark,
//   );
//
//   static TextStyle get regular14WhiteDark => _font(
//     fontSize: 14,
//     fontWeight: FontWeight.w400,
//     color: AppColors.textSecondaryDark,
//   );
//
//   static TextStyle get regular14MainDarkColor => _font(
//     fontSize: 14,
//     fontWeight: FontWeight.w400,
//     color: AppColors.primaryDark,
//   );
//
//   static TextStyle get semi14MainDarkColor => _font(
//     fontSize: 14,
//     fontWeight: FontWeight.w700,
//     color: AppColors.primaryDark,
//   );
//
//   static TextStyle get medium16White => _font(
//     fontSize: 16,
//     fontWeight: FontWeight.w500,
//     color: AppColors.textPrimaryDark,
//   );
//
//   static TextStyle get medium16MainDarkColor => _font(
//     fontSize: 16,
//     fontWeight: FontWeight.w500,
//     color: AppColors.primaryDark,
//   );
//
//   static TextStyle get medium18White => _font(
//     fontSize: 18,
//     fontWeight: FontWeight.w500,
//     color: AppColors.textPrimaryDark,
//   );
//
//   static TextStyle get medium18MainDarkColor => _font(
//     fontSize: 18,
//     fontWeight: FontWeight.w500,
//     color: AppColors.primaryDark,
//   );
//
//   static TextStyle get medium20White => _font(
//     fontSize: 20,
//     fontWeight: FontWeight.w500,
//     color: AppColors.textPrimaryDark,
//   );
//
//   static TextStyle get semi20White => _font(
//     fontSize: 20,
//     fontWeight: FontWeight.w700,
//     color: AppColors.textPrimaryDark,
//   );
//
//   static TextStyle get semi24MainDarkColor => _font(
//     fontSize: 24,
//     fontWeight: FontWeight.w700,
//     color: AppColors.primaryDark,
//   );
// }