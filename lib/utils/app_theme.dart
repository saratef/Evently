import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.transparent,
      centerTitle: true,

    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.backgroundLight,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.textPrimaryDark,
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: AppColors.disabled,
      selectedLabelStyle: AppStyles.regular12MainLightColor,
      unselectedLabelStyle: AppStyles.regular12GreyColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryLight,
      foregroundColor: AppColors.textPrimaryDark,
      shape: CircleBorder(),
    ),
    cardColor: AppColors.primaryLight,
    dividerColor: AppColors.strokeLight,
    highlightColor: AppColors.textPrimaryDark,
    textTheme: TextTheme(
      headlineLarge: AppStyles.semi20Black,
      headlineMedium: AppStyles.medium16Black,
      bodyLarge: AppStyles.regular14Grey,
      headlineSmall: AppStyles.semi24MainLightColor,
      labelMedium: AppStyles.medium16MainColor,
      labelSmall: AppStyles.medium18MainColor,
      labelLarge: AppStyles.semi14MainLightColor,
      bodyMedium: AppStyles.semi16MainLightColor,
      bodySmall: AppStyles.medium14Black,
      titleLarge: AppStyles.regular14MainLightColor,
      titleMedium: AppStyles.medium20BlackColor,
      titleSmall: AppStyles.medium18Black,
      displaySmall: AppStyles.semi14White,
        displayMedium: AppStyles.underlineSemi14MainLightColor

    ),
  );
  static final ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.transparent,
      centerTitle: true,

    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.backgroundDark,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.inputDark,
      selectedItemColor: AppColors.primaryDark,
      unselectedItemColor: AppColors.disabled,
      selectedLabelStyle: AppStyles.regular12MainDarkColor,
      unselectedLabelStyle: AppStyles.regular12WhiteDarkColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: AppColors.textPrimaryDark,
        shape:CircleBorder()
    ),

    cardColor: AppColors.primaryDark,
    dividerColor: AppColors.strokeDark,
    highlightColor: AppColors.inputDark,

    textTheme: TextTheme(
      headlineLarge: AppStyles.semi20White,
      headlineMedium: AppStyles.medium16White,
      bodyLarge: AppStyles.regular14WhiteDark,
      headlineSmall: AppStyles.semi24MainDarkColor,
      labelMedium: AppStyles.medium16MainDarkColor,
      labelSmall: AppStyles.medium18MainDarkColor,
      labelLarge: AppStyles.semi14MainDarkColor,
      bodyMedium: AppStyles.semi16MainDark,
      bodySmall: AppStyles.medium14White,
      titleLarge: AppStyles.regular14MainDarkColor,
      titleMedium: AppStyles.medium20White,
      titleSmall: AppStyles.medium18White,
        displaySmall: AppStyles.semi14White,
      displayMedium: AppStyles.underlineSemi14MainDarkColor

    ),
  );
}
