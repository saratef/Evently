
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/ui/widgets/custom_elevated_button.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/theme_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/dialog_utils.dart';


class ForgetPasswordTab extends StatefulWidget {
  const ForgetPasswordTab({super.key});

  @override
  State<ForgetPasswordTab> createState() => _ForgetPasswordTabState();
}

class _ForgetPasswordTabState extends State<ForgetPasswordTab> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width=context.width;
    double height=context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * .02,
            vertical: height * .01,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal:width* .03,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: BoxBorder.all(
                color: themeProvider.isDark
                    ? AppColors.strokeDark
                    : AppColors.strokeLight,
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                size: 30,
                Icons.arrow_back_ios,
                color: themeProvider.isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.primaryLight,
              ),
            ),
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(
          horizontal: width * .02,
        ),
        backgroundColor: AppColors.transparent,
        title: Text(
          LocaleKeys.forgetPassword.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .03,
          vertical:height * .03,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: height * .04,
              children: [
                Image(
                  image: AssetImage(
                    themeProvider.isDark
                        ? AppImages.forgetPassword
                        : AppImages.forgetPassword,
                  ),
                ),
                CustomTextFormField(
                  borderColor: Theme.of(context).dividerColor,
                  hintText:LocaleKeys.enterYourEmail.tr(),
                  controller: emailController,
                  onValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.enterYourEmail.tr();
                    }
                    return null;
                  },
                ),
                CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      resetPassword(email: emailController.text);
                    }
                  },
                  verticalPadding: height * .01,
                  backgroundColor: Theme.of(context).cardColor,
                  child: Text(
                    LocaleKeys.resetPassword.tr(),
                    style: AppStyles.medium20White,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword({required String email}) async {
    //todo:show loading
    DialogUtils.showLoading(context: context, loadingText: 'Loading...');
    try {
      //todo:send request to firebase
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      //todo:hide loading
      //mounted is true=>success
      if(mounted)DialogUtils.hideLoading(context: context);
      if(mounted){
        DialogUtils.showMessage(context: context,
          message: 'Reset link has been sent to your email!',
          positiveActionName: 'OK',
        );
      }
    }on FirebaseAuthException catch(e){
      //todo:hide loading in error state
      if(mounted)DialogUtils.hideLoading(context: context);
      String errorMessage = 'Something went wrong';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      }
      //todo:show error message
      if(mounted){
        DialogUtils.showMessage(context: context, message: errorMessage,positiveActionName: 'OK');
      }
    }catch(e){
      if (mounted) DialogUtils.hideLoading(context: context,);
      if(mounted){      DialogUtils.showMessage(context: context, message: e.toString(),positiveActionName: 'Ok');
      }
    }
  }
}