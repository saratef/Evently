import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/widgets/custom_elevated_button.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../../model/user.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/dialog_utils.dart';
import '../../../utils/firebase_utils.dart';
import '../../../utils/size_utils.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var rePasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isObscure = true;
  bool isObscure2 = true;

  @override
  Widget build(BuildContext context) {
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
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: height * .02,
                children: [
                  Image.asset(
                    AppImages.eventlyLogo,
                    color: Theme.of(context).cardColor,
                  ),
                  Text(
                    LocaleKeys.createAnAccount.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  CustomTextFormField(
                    controller: nameController,
                    textInputType: TextInputType.text,
                    onValidator: (text) {
                      if (text.trim() == null || text.trim().isEmpty) {
                        return 'Please Enter Your Name.';
                      }
                      return null;
                    },
                    borderColor: Theme.of(context).dividerColor,
                    fillColor: isDark ? AppColors.inputDark : AppColors.textPrimaryDark,
                    filled: true,
                    hintText: LocaleKeys.enterYourName.tr(),
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: ImageIcon(
                      AssetImage(AppIcons.unselectedProfile),
                      color: AppColors.disabled,
                    ),
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
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
                    borderColor: Theme.of(context).dividerColor,
                    fillColor: isDark ? AppColors.inputDark : AppColors.textPrimaryDark,
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
                    textInputType: TextInputType.visiblePassword,
                    obscureText: isObscure,
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
                    fillColor: isDark ? AppColors.inputDark : AppColors.textPrimaryDark,
                    filled: true,
                    hintText: LocaleKeys.enterYourPassword.tr(),
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: ImageIcon(
                      AssetImage(AppIcons.password),
                      color: AppColors.disabled,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        isObscure = !isObscure;
                        setState(() {});
                      },
                      icon: Icon(
                        isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: AppColors.disabled,
                      ),
                    ),
                  ),
                  CustomTextFormField(
                    controller: rePasswordController,
                    textInputType: TextInputType.visiblePassword,
                    obscureText: isObscure2,
                    onValidator: (text) {
                      if (text.trim() == null || text.trim().isEmpty) {
                        return 'Please Confirm Your Password.';
                      }
                      if (passwordController.text != text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    borderColor: Theme.of(context).dividerColor,
                    fillColor: isDark ? AppColors.inputDark : AppColors.textPrimaryDark,
                    filled: true,
                    hintText: LocaleKeys.confirmYourPassword.tr(),
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: ImageIcon(
                      AssetImage(AppIcons.password),
                      color: AppColors.disabled,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        isObscure2 = !isObscure2;
                        setState(() {});
                      },
                      icon: Icon(
                        isObscure2 ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: AppColors.disabled,
                      ),
                    ),
                  ),
                  CustomElevatedButton(
                    onPressed: _register,
                    backgroundColor: Theme.of(context).cardColor,
                    verticalPadding: height * .01,
                    child: Text(
                      LocaleKeys.signUp.tr(),
                      style: AppStyles.medium20White,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.alreadyHaveAnAccount.tr(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          LocaleKeys.login.tr(),
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
                      signUpWithGoogle();
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
                          LocaleKeys.signUpWithGoogle.tr(),
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

  void _register()async {
    if (formKey.currentState?.validate()==true){

      try {
        DialogUtils.showLoading(context: context, loadingText: 'Waiting..');
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser=MyUser(
            name: nameController.text,

            email: emailController.text,
            id: credential.user?.uid??'');
        await FirebaseUtils.addUserInFireStore(myUser);

        var userProvider=Provider.of<UserProvider>(context,listen: false);
        userProvider.updateUser(myUser);
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(context: context,
          message: 'Register Successfully',
          title: 'Success',
          positiveActionName: 'Ok',
          positiveAction: () {
            Navigator.pushNamed(context, AppRoutes.homeRouteName);
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: 'The password provided is too weak.',
            title: 'Error ',
            positiveActionName: 'Ok',

          );
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: 'The account already exists for that email.',
            title: 'Error ',
            positiveActionName: 'Ok',

          );
        }
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: 'Error ',
          positiveActionName: 'Ok',

        );
      }

    }
  }
  void signUpWithGoogle() async {
    final googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut();

      final GoogleSignInAccount? gUser = await googleSignIn.signIn();

      if (gUser == null) {
        return;
      }

      if (!mounted) return;
      DialogUtils.showLoading(context: context, loadingText: 'Creating account...');

      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: gAuth.idToken,
      );

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;

        var user = await FirebaseUtils.readUserFromFireStore(uid);

        if (user == null) {
          var newUser = MyUser(
            id: uid,
            name: userCredential.user!.displayName ?? 'No Name',
            email: userCredential.user!.email ?? '',
          );
          await FirebaseUtils.addUserInFireStore(newUser);
          user = newUser;
        }

        if (!mounted) return;

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);

        DialogUtils.hideLoading(context: context);

        DialogUtils.showMessage(
          context: context,
          message: 'Account Created Successfully',
          title: 'Success',
          positiveActionName: 'Ok',
          positiveAction: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.homeRouteName,
                  (route) => false,
            );
          },
        );
      }
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
