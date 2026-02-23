import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_colors.dart';

class OrderFailedScreen extends StatelessWidget {
  const OrderFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            // Error Illustration
            const Icon(
                Icons.cancel_outlined,
                size: 150,
                color: Colors.redAccent
            ),
            const SizedBox(height: 40),
            const Text(
              "Oops! Order Failed",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Something went wrong with your\norder. Please try again or check your\npayment method.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const Spacer(flex: 2),

            // ផ្នែកប៊ូតុងដែលបាន Update ដើម្បីរុញឡើងលើ
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25), // រុញប៊ូតុងឡើងលើពីបាត 25 units
                child: Column(
                  children: [
                    _buildButton(
                      text: "Please Try Again",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      isPrimary: true,
                    ),
                    const SizedBox(height: 15), // បន្ថែមចន្លោះរវាងប៊ូតុងទាំងពីរ
                    _buildButton(
                      text: "Back to home",
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      isPrimary: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primaryAppColor : Colors.transparent,
          side: isPrimary ? BorderSide.none : const BorderSide(color: Colors.black12), // បន្ថែមស៊ុមស្តើងឱ្យប៊ូតុង secondary
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isPrimary ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}