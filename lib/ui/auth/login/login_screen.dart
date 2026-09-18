import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/widgets/custom_elevated_button.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';


import '../../../model/user.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/dialog_utils.dart';
import '../../../utils/firebase_utils.dart';
import '../../../utils/size_utils.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isObscure=true;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = Provider.of<AppThemeProvider>(context).isDark;
    var width = context.width;
    var height = context.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * .04,
            vertical: height * .02,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: height * .02,
                children: [
                  Image.asset(
                    AppImages.eventlyLogo,
                    color: Theme.of(context).cardColor,
                  ),
                  Text(
                    LocaleKeys.loginToYourAccount.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    onValidator: (text) {
                      if (text.trim() == null || text.trim().isEmpty) {
                        return 'Please Enter Your Email.';
                      }
                      final bool emailValidation = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      ).hasMatch(emailController.text);

                      if (!emailValidation) {
                        return 'Please,Enter A Valid Email.';
                      }

                      return null;
                    },
                    textInputType:TextInputType.emailAddress,

                    borderColor: Theme.of(context).dividerColor,
                    fillColor: isDark
                        ? AppColors.inputDark
                        : AppColors.textPrimaryDark,
                    filled: true,
                    hintText: LocaleKeys.enterYourEmail.tr(),
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: ImageIcon(
                      AssetImage(AppIcons.email),
                      color: AppColors.disabled,
                    ),
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    onValidator: (text) {
                      if (text.trim() == null || text.trim().isEmpty) {
                        return 'Please Enter Your Password.';
                      }

                      if (passwordController.text.length < 6) {
                        return 'Password must be at least 6 characters';
                      }

                      return null;
                    },
                    borderColor: Theme.of(context).dividerColor,
                    obscureText: isObscure,
                    fillColor: isDark
                        ? AppColors.inputDark
                        : AppColors.textPrimaryDark,
                    filled: true,
                    hintText: LocaleKeys.enterYourPassword.tr(),
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: ImageIcon(
                      AssetImage(AppIcons.password),
                      color: AppColors.disabled,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        isObscure= !isObscure;
                        setState(() {

                        });


                      },
                      icon: Icon(
                        isObscure?Icons.visibility_off_outlined
                        :Icons.visibility_outlined,
                        color: AppColors.disabled,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.forgetPasswordRouteName);
                        },
                        child: Text(
                          LocaleKeys.forgetPassword.tr(),
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                  CustomElevatedButton(

                    onPressed: () {
                      login();
                    },

                    backgroundColor: Theme.of(context).cardColor,
                    verticalPadding: height * .01,
                    child: Text(
                      LocaleKeys.login.tr(),
                      style: AppStyles.medium20White,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.doNotHaveAccount.tr(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.registerRouteName,
                          );
                        },
                        child: Text(
                          LocaleKeys.createAnAccount.tr(),
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Theme.of(context).dividerColor,
                          indent: width * .01,
                          endIndent: width * .04,
                        ),
                      ),
                      Text(
                        LocaleKeys.or.tr(),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Theme.of(context).dividerColor,
                          indent: width * .04,
                          endIndent: width * .01,
                        ),
                      ),
                    ],
                  ),
                  CustomElevatedButton(
                    verticalPadding: height * .02,
                    onPressed: () {
                      signInWithGoogle();
                      },
                    backgroundColor: isDark
                        ? AppColors.inputDark
                        : AppColors.textPrimaryDark,
                    borderColor: Theme.of(context).dividerColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: width * .02,
                      children: [
                        Image.asset(AppIcons.googleIcon),

                        Text(
                          LocaleKeys.loginWithGoogle.tr(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void login() async {
    if (formKey.currentState!.validate() == true) {
      try {
        DialogUtils.showLoading(context: context, loadingText: 'Loading...');

        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );

        var user = await FirebaseUtils.readUserFromFireStore(
          credential.user?.uid ?? '',
        );

        DialogUtils.hideLoading(context: context);

        if (user == null) {
          DialogUtils.showMessage(
            context: context,
            message: 'User data not found in database.',
            title: 'Error',
            positiveActionName: 'Ok',
          );
          return;
        }

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);

        DialogUtils.showMessage(
          context: context,
          message: 'Login Successfully',
          title: 'Success',
          positiveActionName: 'Ok',
          positiveAction: () {
            Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
          },
        );
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideLoading(context: context);

        String errorMessage = 'An error occurred. Please try again.';
        if (e.code == 'invalid-credential' || e.code == 'wrong-password' || e.code == 'user-not-found') {
          errorMessage = 'The supplied auth credential is incorrect, malformed or has expired.';
        } else if (e.message != null) {
          errorMessage = e.message!;
        }

        DialogUtils.showMessage(
          context: context,
          message: errorMessage,
          title: 'Error',
          positiveActionName: 'Ok',
        );
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: 'Error',
          positiveActionName: 'Ok',
        );
      }
    }
  }
  void signInWithGoogle() async {
    try {
      DialogUtils.showLoading(context: context, loadingText: 'Loading...');
      await GoogleSignIn().signOut();

      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      if (gUser == null) {
        if (mounted) DialogUtils.hideLoading(context: context);
        return;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      var user = await FirebaseUtils.readUserFromFireStore(
        userCredential.user?.uid ?? '',
      );

      if (user == null && userCredential.user != null) {
        var newUser = MyUser(
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName ?? '',
          email: userCredential.user!.email ?? '',
        );
        await FirebaseUtils.addUserInFireStore(newUser);
        user = newUser;
      }

      if (!mounted) return;

      if (user != null) {
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
      }

      DialogUtils.hideLoading(context: context);

      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRoutes.homeRouteName, (route) => false);
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
  }
}
