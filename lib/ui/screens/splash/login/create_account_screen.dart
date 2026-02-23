import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:grocery_app/core/constants/app_colors.dart';
import 'package:grocery_app/routes/app_routes.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  String? _completePhoneNumber;
  bool _isLoading = false;
  bool _isPhoneValid = false;

  void _showMessage(String message, Color color, {IconData? icon}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon ?? Icons.info, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontFamily: 'KhmerOS', fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        elevation: 6,
      ),
    );
  }

  Future<void> _handleContinue() async {
    if (!_isPhoneValid) {
      _showMessage('សូមបញ្ចូលលេខទូរស័ព្ទត្រឹមត្រូវ', Colors.red,
          icon: Icons.error);
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isLoading = false);

    _showMessage('បានផ្ញើលេខកូដទៅលេខទូរស័ព្ទរបស់អ្នក', Colors.green,
        icon: Icons.check_circle);

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      Navigator.pushNamed(
        context,
        AppRoutes.verification,
        arguments: _completePhoneNumber,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 20, color: Color(0xFF212121)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'បង្កើតគណនី',
          style: TextStyle(
            fontFamily: 'KhmerOS',
            color: Color(0xFF212121),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.primaryAppColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '2',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'លេខទូរស័ព្ទ',
                    style: TextStyle(
                      fontFamily: 'KhmerOS',
                      fontSize: 12,
                      color: AppColors.primaryAppColor,
                    ),
                  ),
                  Text(
                    'ផ្ទៀងផ្ទាត់',
                    style: TextStyle(
                      fontFamily: 'KhmerOS',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'បញ្ចប់',
                    style: TextStyle(
                      fontFamily: 'KhmerOS',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Title
              const Text(
                'បញ្ចូលលេខទូរស័ព្ទរបស់អ្នក',
                style: TextStyle(
                  fontFamily: 'KhmerOS',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'យើងនឹងផ្ញើលេខកូដផ្ទៀងផ្ទាត់ទៅលេខទូរស័ព្ទរបស់អ្នក',
                style: TextStyle(
                  fontFamily: 'KhmerOS',
                  fontSize: 14,
                  color: Color(0xFF757575),
                ),
              ),
              const SizedBox(height: 40),

              // Phone input
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isPhoneValid
                        ? AppColors.primaryAppColor
                        : Colors.grey.shade300,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: IntlPhoneField(
                  initialCountryCode: 'KH',
                  flagsButtonPadding: const EdgeInsets.only(left: 12),
                  dropdownIconPosition: IconPosition.trailing,
                  dropdownIcon: Icon(Icons.arrow_drop_down_rounded,
                      color: Colors.grey.shade600),
                  style: const TextStyle(
                    fontFamily: 'KhmerOS',
                    fontSize: 16,
                    color: Color(0xFF212121),
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'លេខទូរស័ព្ទ',
                    hintStyle: TextStyle(
                      fontFamily: 'KhmerOS',
                      color: Color(0xFF9E9E9E),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    counterText: '',
                  ),
                  onChanged: (phone) {
                    final phoneNumber =
                    phone.completeNumber.replaceAll(RegExp(r'\D'), '');
                    setState(() {
                      _completePhoneNumber = phone.completeNumber;
                      _isPhoneValid = phoneNumber.length >= 9;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Note
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_rounded, color: Colors.blue.shade600, size: 18),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'លេខកូដផ្ទៀងផ្ទាត់ត្រូវបានផ្ញើតាមសារ SMS',
                        style: TextStyle(
                          fontFamily: 'KhmerOS',
                          fontSize: 13,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isPhoneValid && !_isLoading ? _handleContinue : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryAppColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'បន្តទៅផ្ទៀងផ្ទាត់',
                        style: TextStyle(
                          fontFamily: 'KhmerOS',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // OR Divider
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'ឬប្រើប្រាស់',
                      style: TextStyle(
                        fontFamily: 'KhmerOS',
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Google Signup Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showMessage('កំពុងភ្ជាប់ជាមួយ Google...',
                        const Color(0xFFDB4437),
                        icon: Icons.g_mobiledata_rounded);
                  },
                  icon: Icon(Icons.g_mobiledata_rounded,
                      color: Colors.red.shade600),
                  label: const Text(
                    'បន្តជាមួយ Google',
                    style: TextStyle(
                      fontFamily: 'KhmerOS',
                      color: Color(0xFF212121),
                      fontSize: 14,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Already have account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "មានគណនីរួចហើយ? ",
                    style: TextStyle(
                      fontFamily: 'KhmerOS',
                      color: Color(0xFF424242),
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.loginAccount),
                    child: Text(
                      "ចូលទីនេះ",
                      style: TextStyle(
                        fontFamily: 'KhmerOS',
                        color: AppColors.primaryAppColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}