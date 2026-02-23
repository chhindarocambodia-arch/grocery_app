
import 'package:flutter/material.dart';
import 'package:grocery_app/core/themes/app_theme.dart';
import 'package:grocery_app/routes/app_routes.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyGrocer',
      debugShowCheckedModeBanner: false,

      // --- Routing Setup ---
      initialRoute: AppRoutes.splash, // Start on the SplashScreen
      routes: AppRoutes.routes,       // Use the defined map of routes

      // --- Theming Setup ---
      theme: AppTheme.lightTheme,
    );
  }
}