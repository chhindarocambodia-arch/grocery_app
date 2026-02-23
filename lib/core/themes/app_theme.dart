import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_colors.dart';

class AppTheme {
  static const TextTheme _textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'KhmerOS',
      fontSize: 34.0,
      fontWeight: FontWeight.w900,
      color: AppColors.primaryTextColor,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'KhmerOS',
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryTextColor,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'KhmerOS',
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: AppColors.primaryTextColor,
    ),
    bodySmall: TextStyle(
      fontFamily: 'KhmerOS',
      fontSize: 12.0,
      color: AppColors.secondaryTextColor,
    ),
    labelLarge: TextStyle(
      fontFamily: 'KhmerOS',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryTextColor,
    ),
  );

  static TextStyle get headlineStyle => _textTheme.headlineLarge!;

  static TextStyle get statusBarTextStyle => const TextStyle(
    fontFamily: 'KhmerOS',
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryAppColor,
    scaffoldBackgroundColor: AppColors.backgroundWhite,
    primarySwatch: Colors.green,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'KhmerOS', // <-- KhmerOS applied globally

    // Typography
    textTheme: _textTheme,

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryAppColor,
        foregroundColor: AppColors.backgroundWhite,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 4,
        shadowColor: AppColors.primaryAppColor.withOpacity(0.5),
        textStyle: const TextStyle(
          fontFamily: 'KhmerOS',
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    // Input Decorations
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        fontFamily: 'KhmerOS',
        color: AppColors.secondaryTextColor,
      ),
      floatingLabelStyle: TextStyle(
        fontFamily: 'KhmerOS',
        color: AppColors.primaryAppColor,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: AppColors.borderColor, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: AppColors.borderColor, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: AppColors.primaryAppColor, width: 2.0),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    ),
  );
}