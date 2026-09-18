import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/home/tabs/profile/language_bottom_sheet.dart';
import 'package:evently/ui/home/tabs/profile/profille_card_widget.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_routes.dart';
import '../../../../utils/dialog_utils.dart';

class ProfileTab extends StatefulWidget {
  static  WidgetStateProperty<Icon> thumbIcon =
      WidgetStateProperty<Icon>.fromMap(<WidgetStatesConstraint, Icon>{
        WidgetState.selected: Icon(Icons.dark_mode_outlined),
        WidgetState.any: Icon(
          Icons.light_mode_rounded,
          color: AppColors.textSecondaryLight,
        ),
      });

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  @override
  Widget build(BuildContext context) {
    double width = context.width;
    double height = context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = themeProvider.isDark;


    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .04,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: width * .15,
                backgroundImage: AssetImage(AppImages.darkBook),
              ),
              Text(
                'sara',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                'sara@gmail.com',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * .05),
              ProfileCardWidget(
                isDrak: isDark,
                title: LocaleKeys.theme,
                trailing: Switch(
                  activeColor: AppColors.textPrimaryDark,
                  activeTrackColor: AppColors.primaryDark,
                  inactiveTrackColor: AppColors.disabled,
                  inactiveThumbColor: AppColors.textPrimaryDark,
                  trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.disabled)) {
                      return AppColors.transparent;
                    }
                    return AppColors.transparent; // Use the default color.
                  }),

                  thumbIcon: ProfileTab.thumbIcon,
                  value: themeProvider.isDark,
                  onChanged: (value) {
                    themeProvider.changeAppTheme(value);
                  },
                ),
              ),
              ProfileCardWidget(
                isDrak: isDark,

                title: LocaleKeys.language,
                trailing: InkWell(
                  onTap: () {
                    //todo: show bottom sheet
                    showLanguageBottomSheet();
                  },
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: isDark
                        ? AppColors.primaryDark
                        : AppColors.primaryLight,
                  ),
                ),
              ),
              ProfileCardWidget(
                isDrak: isDark,

                title: LocaleKeys.logout,
                trailing: IconButton(
                  onPressed: (){
                    logout();

                  },
                  icon: ImageIcon(
                    AssetImage(AppIcons.logout),
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }
  void logout() {
    DialogUtils.showMessage(
      context: context,
      message: 'Are you sure you want to log out?',
      title: 'Logout',
      positiveActionName: 'Yes',
      positiveAction: () async {
        DialogUtils.showLoading(context: context, loadingText: 'Logging out...');

        try {
          await FirebaseAuth.instance.signOut();

          await GoogleSignIn().signOut();

          if (!mounted) return;

          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.clearUser();

          DialogUtils.hideLoading(context: context);

          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.loginRouteName,
                (route) => false,
          );
        } catch (e) {
          if (mounted) {
            DialogUtils.hideLoading(context: context);
            DialogUtils.showMessage(
              context: context,
              message: e.toString(),
              title: 'Error',
              positiveActionName: 'Ok',
            );
          }
        }
      },
      negativeActionName: 'Cancel',
    );
  }}
