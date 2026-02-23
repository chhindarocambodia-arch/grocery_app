import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_strings.dart';
import 'package:grocery_app/ui/screens/homescreen/account/policy_screen.dart';
import 'package:grocery_app/ui/screens/locationselectionscreen/new_password_screen.dart';
import 'package:grocery_app/ui/screens/splash/splash_screen.dart';
import 'package:grocery_app/ui/screens/splash/view/view_screen.dart';
import 'package:grocery_app/ui/screens/splash/login/create_account_screen.dart';
import 'package:grocery_app/ui/screens/splash/login/sign_up_screen.dart';
import 'package:grocery_app/ui/screens/verification/verification_screen.dart';
import 'package:grocery_app/ui/screens/locationselectionscreen/forgotpass_verification_screen.dart';
import 'package:grocery_app/ui/screens/locationselectionscreen/location_selection_screen.dart';
import 'package:grocery_app/ui/screens/locationselectionscreen/log_account.dart';
import 'package:grocery_app/ui/screens/locationselectionscreen/forgot_password_screen.dart';
import 'package:grocery_app/ui/screens/homescreen/home_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const view = '/view';
  static const create = '/createAccount';
  static const signup = '/signup';
  static const verification = '/verification';
  static const forgotPassVerification = '/forgotPassVerification';
  static const locationSelection = '/locationSelection';
  static const loginAccount = '/loginAccount';
  static const forgotPassword = '/forgotPassword';
  static const home = '/home';
  static const newPassword = '/newPassword';
  static const termsOfService = '/termsOfService';
  static const privacyPolicy = '/privacyPolicy';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    view: (context) => const ViewScreen(),
    create: (context) => const CreateAccountScreen(),
    signup: (context) => const SignUpScreen(),
    verification: (context) => const VerificationScreen(),
    forgotPassVerification: (context) => const ForgotPassVerificationScreen(),

    locationSelection: (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      bool isSignup = (args is bool) ? args : false;
      return LocationSelectionScreen(isSignupFlow: isSignup);
    },

    loginAccount: (context) => const LoginAccount(),
    forgotPassword: (context) => const ForgotPasswordScreen(),
    home: (context) => const HomeScreen(),
    newPassword: (context) => const NewPasswordScreen(),

    termsOfService: (context) => _buildDynamicPolicy(
      context,
      "លក្ខខណ្ឌនៃសេវាកម្ម", // "Terms of Service" in Khmer
      AppStrings.termsContent,
    ),
    privacyPolicy: (context) => _buildDynamicPolicy(
      context,
      "គោលការណ៍ភាពឯកជន", // "Privacy Policy" in Khmer
      AppStrings.privacyContent,
    ),
  };

  // Helper method to keep the map clean
  static Widget _buildDynamicPolicy(BuildContext context, String defaultTitle, String defaultContent) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    return PolicyDetailScreen(
      title: args?['title'] ?? defaultTitle,
      content: args?['content'] ?? defaultContent,
      lastUpdated: args?['lastUpdated'] ?? "មករា ២០២៦", // "January 2026" in Khmer
    );
  }
}