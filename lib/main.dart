import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/auth/forget_password/forget_password_screen.dart';
import 'package:evently/ui/auth/login/login_screen.dart';
import 'package:evently/ui/auth/register/register_screen.dart';
import 'package:evently/ui/home/add_event/add_event_screen.dart';
import 'package:evently/ui/home/home_screen.dart';
import 'package:evently/ui/home/tabs/home/edit_event_screen.dart';
import 'package:evently/ui/home/tabs/home/event_detailes_screen.dart';
import 'package:evently/ui/onboarding/on_boarding.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(

        providers: [
          ChangeNotifierProvider(create: (context) => AppThemeProvider(),),
          ChangeNotifierProvider(create: (context) => UserProvider(),),

        ],
      child: EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // AppStyles.isArabic = context.locale.languageCode == 'ar';
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: AppRoutes.loginRouteName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appThemeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
      routes: {
        AppRoutes.onboardingRouteName: (context) => OnBoarding(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.forgetPasswordRouteName: (context) => ForgetPasswordTab(),
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        AppRoutes.addEventRouteName: (context) => AddEventScreen(),
        AppRoutes.editEventRouteName: (context) => EditEventScreen(),
        AppRoutes.eventDetailsRouteName: (context) => EventDetailsScreen(),
      },
    );
  }
}
