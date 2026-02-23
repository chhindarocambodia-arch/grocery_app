import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_colors.dart';
import 'package:grocery_app/core/constants/app_strings.dart';
import 'package:grocery_app/routes/app_routes.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 22),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          "អំពីកម្មវិធី",
          style: TextStyle(
            fontFamily: 'KhmerOS',
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Modern Logo Card
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryAppColor.withOpacity(0.2),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.local_grocery_store,
                size: 60,
                color: AppColors.primaryAppColor,
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "App Grocery",
              style: TextStyle(

                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTextColor),
            ),
            const SizedBox(height: 6),
            const Text(
              "កំណែ 1.0.0",
              style: TextStyle(
                  fontFamily: 'KhmerOS', color: Colors.grey, fontSize: 16),
            ),

            const SizedBox(height: 40),
            const Divider(color: AppColors.borderColor),

            const SizedBox(height: 20),
            const Text(
              "គោលបំណងរបស់យើងគឺធ្វើឱ្យការទិញសម្ភារៈគ្រប់ប្រភេទនៅក្នុងប្រទេសកម្ពុជា ងាយស្រួល លឿន និងអាចចូលដល់បានសម្រាប់គ្រប់គ្នា។ យើងភ្ជាប់អ្នកជាមួយផលិតផលស្រស់ស្អាតក្នុងស្រុក និងម៉ាកអន្តរជាតិ ដឹកជូនដល់ទ្វាររបស់អ្នក។",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'KhmerOS',
                  fontSize: 16,
                  color: AppColors.primaryTextColor,
                  height: 1.5),
            ),

            const SizedBox(height: 40),

            // Modern Info Tiles
            _modernInfoTile(
              context,
              "គោលនយោបាយភាពឯកជន",
              AppColors.primaryAppColor,
                  () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.privacyPolicy,
                  arguments: {
                    "title": "គោលនយោបាយភាពឯកជន",
                    "content": AppStrings.privacyContent,
                  },
                );
              },
            ),

            const SizedBox(height: 16),

            _modernInfoTile(
              context,
              "ល័ក្ខខ័ណ្ឌនៃសេវាកម្ម",
              Colors.deepPurpleAccent,
                  () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.termsOfService,
                  arguments: {
                    "title": "ល័ក្ខខ័ណ្ឌនៃសេវាកម្ម",
                    "content": AppStrings.termsContent,
                  },
                );
              },
            ),

            const SizedBox(height: 50),
            const Text(
              "© 2026 Chhin Daro. រក្សាសិទ្ធិគ្រប់យ៉ាង",
              style: TextStyle(
                  fontFamily: 'KhmerOS', color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _modernInfoTile(BuildContext context, String title, Color accentColor, VoidCallback onTap) {
    return Material(
      elevation: 3,
      shadowColor: accentColor.withOpacity(0.3),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [accentColor.withOpacity(0.8), accentColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(Icons.chevron_right, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontFamily: 'KhmerOS',
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryTextColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
