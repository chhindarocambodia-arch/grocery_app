import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_colors.dart';
import 'package:grocery_app/core/models/product_model.dart';
import 'package:grocery_app/routes/app_routes.dart';
import 'package:lottie/lottie.dart';

class OrderAcceptedScreen extends StatefulWidget {
  const OrderAcceptedScreen({super.key});

  @override
  State<OrderAcceptedScreen> createState() => _OrderAcceptedScreenState();
}

class _OrderAcceptedScreenState extends State<OrderAcceptedScreen> {
  bool _showText = false; // for fade-in effect

  @override
  void initState() {
    super.initState();
    // Clear the cart after order is successful
    WidgetsBinding.instance.addPostFrameCallback((_) {
      globalCartList.clear();
    });
  }

  void _navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
  }

  void _trackOrder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("មុខងារតាមដាននឹងមកឆាប់ៗនេះ!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navigateToHome();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),

              // Lottie animation
              Lottie.asset(
                'assets/lottie/Success(1).json',
                width: MediaQuery.of(context).size.width * 0.7,
                repeat: false,
                onLoaded: (composition) {
                  Future.delayed(composition.duration, () {
                    setState(() {
                      _showText = true;
                    });
                  });
                },
              ),

              const SizedBox(height: 40),

              // Fade-in main text
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _showText ? 1.0 : 0.0,
                child: const Text(
                  "ការបញ្ជាទិញរបស់អ្នក\nត្រូវបានទទួលយកហើយ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    letterSpacing: -0.5,
                    color: Colors.black87,
                    fontFamily: 'KhmerOS',
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Fade-in description text
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _showText ? 1.0 : 0.0,
                child: const Text(
                  "ទំនិញរបស់អ្នកបានបញ្ជាទិញ ហើយកំពុង\nដំណើរការនៅក្នុងប្រព័ន្ធរបស់យើង។",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    height: 1.5,
                    fontFamily: 'KhmerOS',
                  ),
                ),
              ),

              const Spacer(flex: 2),

              // Modern gradient buttons
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      _buildGradientButton(
                        text: "តាមដានការបញ្ជាទិញ",
                        onPressed: _trackOrder,
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primaryAppColor,
                            Color(0xFF4A90E2),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildGradientButton(
                        text: "ត្រឡប់ទៅផ្ទះ",
                        onPressed: _navigateToHome,
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey.shade300,
                            Colors.grey.shade200,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        textColor: Colors.black87,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required String text,
    required VoidCallback onPressed,
    required Gradient gradient,
    Color textColor = Colors.white,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 6,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
                fontFamily: 'KhmerOS',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
