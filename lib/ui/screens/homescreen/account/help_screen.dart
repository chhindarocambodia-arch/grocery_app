import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_colors.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  static const primaryGreen = AppColors.primaryAppColor; // modern primary color
  static const fbColor = Color(0xFF1877F2);
  static const telegramColor = Color(0xFF2AABEE);
  static const phoneColor = Color(0xFF3B8E2D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "ជំនួយ និង ការងារ", // Khmer text
          style: TextStyle(
            fontFamily: 'KhmerOS',
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 32),

            // Modern Support Icon with shadow
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primaryGreen.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.support_agent_rounded,
                size: 80,
                color: primaryGreen,
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              "ត្រូវការជំនួយ?",
              style: TextStyle(
                fontFamily: 'KhmerOS',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryTextColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "ទំនាក់ទំនងក្រុមគាំទ្ររបស់យើងតាមជម្រើសខាងក្រោម",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'KhmerOS',
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 40),

            // Modern Buttons
            _modernHelpButton(
              title: "ជជែក Facebook",
              icon: Icons.facebook,
              color: fbColor,
              onTap: () {},
            ),
            const SizedBox(height: 20),

            _modernHelpButton(
              title: "Telegram",
              icon: Icons.send,
              color: telegramColor,
              onTap: () {},
            ),
            const SizedBox(height: 20),

            _modernHelpButton(
              title: "ទូរស័ព្ទ",
              icon: Icons.phone,
              color: phoneColor,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _modernHelpButton({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(18),
      elevation: 5,
      shadowColor: color.withOpacity(0.4),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          height: 65,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.85),
                color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'KhmerOS',
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 40), // center alignment balance
            ],
          ),
        ),
      ),
    );
  }
}
