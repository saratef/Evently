import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';

class LanguageBottomSheet extends StatelessWidget {

  const LanguageBottomSheet({super.key});


  @override
  Widget build(BuildContext context) {
    double width = context.width;
    double height = context.height;
    bool isDrak = Provider.of<AppThemeProvider>(context).isDark;


    final bool isEnglish = context.locale.languageCode == 'en';
    final bool isArabic = context.locale.languageCode == 'ar';

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * .03,
        horizontal: width * .06,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: height * .03,
        children: [
          InkWell(
            onTap: () {
              if (!isEnglish) {
                context.setLocale(const Locale('en'));

              }

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.english.tr(),
                  style: isEnglish
                      ? Theme.of(context).textTheme.headlineSmall
                      : Theme.of(context).textTheme.headlineMedium,
                ),
                if (isEnglish)
                  Icon(
                    Icons.done_rounded,
                    color: isDrak?AppColors.primaryDark:AppColors.primaryLight,
                    size: width * .09,
                  ),
              ],
            ),
          ),

          InkWell(
            onTap: () {
              if (!isArabic) {
                context.setLocale(const Locale('ar'));

              }

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.arabic.tr(),
                  style: isArabic
                      ? Theme.of(context).textTheme.headlineSmall
                      : Theme.of(context).textTheme.headlineMedium,
                ),
                if (isArabic)
                  Icon(
                    Icons.done_rounded,
                    color: isDrak?AppColors.primaryDark:AppColors.primaryLight,
                    size: width * .09,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}