import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/core/constants/app_colors.dart';
import 'package:grocery_app/routes/app_routes.dart';

class VerificationScreen extends StatefulWidget {
  final String? phoneNumber;
  const VerificationScreen({super.key, this.phoneNumber});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final int _resendTimeout = 30;
  int _resendCountdown = 0;
  Timer? _resendTimer;
  final List<TextEditingController> _otpControllers =
  List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _otpFocusNodes =
  List.generate(6, (index) => FocusNode());
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        FocusScope.of(context).requestFocus(_otpFocusNodes[0]);
      }
    });
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    setState(() => _resendCountdown = _resendTimeout);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_resendCountdown == 0) {
        timer.cancel();
      } else {
        setState(() => _resendCountdown--);
      }
    });
  }

  String get _enteredOtp => _otpControllers.map((c) => c.text).join();

  void _handleOtpInput(int index, String value) {
    if (value.isNotEmpty && value.length == 1) {
      if (index < 5) {
        FocusScope.of(context).requestFocus(_otpFocusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus();
        _verifyOtp();
      }
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_otpFocusNodes[index - 1]);
    }
  }

  void _showSnackBar(String message, Color color, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
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

  Future<void> _verifyOtp() async {
    if (_enteredOtp.length < 6) {
      _showSnackBar('សូមបំពេញលេខកូដទាំង ៦ ខ្ទង់', Colors.orange, Icons.warning);
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (_enteredOtp == '123456') {
      _showSuccessDialog();
    } else {
      _showSnackBar('លេខកូដមិនត្រឹមត្រូវ', Colors.red, Icons.error);
      for (var controller in _otpControllers) {
        controller.clear();
      }
      if (mounted) {
        FocusScope.of(context).requestFocus(_otpFocusNodes[0]);
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: Colors.green,
              size: 60,
            ),
            const SizedBox(height: 16),
            const Text(
              'ផ្ទៀងផ្ទាត់ដោយជោគជ័យ!',
              style: TextStyle(
                fontFamily: 'KhmerOS',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'លេខទូរស័ព្ទរបស់អ្នកត្រូវបានផ្ទៀងផ្ទាត់ហើយ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'KhmerOS',
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    AppRoutes.locationSelection,
                    arguments: true,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryAppColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'បន្ត',
                  style: TextStyle(
                    fontFamily: 'KhmerOS',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isOtpComplete = _enteredOtp.length == 6;
    final bool isResendDisabled = _resendCountdown > 0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF212121), size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "ផ្ទៀងផ្ទាត់លេខកូដ",
            style: TextStyle(
              color: Color(0xFF212121),
              fontWeight: FontWeight.w600,
              fontSize: 18,
              fontFamily: 'KhmerOS',
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  'បញ្ចូលលេខកូដ ៦ ខ្ទង់',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF212121),
                    fontFamily: 'KhmerOS',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'បានផ្ញើលេខកូដទៅលេខទូរស័ព្ទ ${widget.phoneNumber ?? ""}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF757575),
                    fontFamily: 'KhmerOS',
                  ),
                ),
                const SizedBox(height: 32),

                // OTP Input
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 48,
                      child: TextField(
                        controller: _otpControllers[index],
                        focusNode: _otpFocusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121),
                          fontFamily: 'KhmerOS',
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.primaryAppColor,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (value) => _handleOtpInput(index, value),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),

                // Resend Code
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isResendDisabled
                          ? 'អាចស្នើសុំលេខកូដថ្មីបានក្នុងរយៈពេល '
                          : 'មិនទទួលបានលេខកូដទេ? ',
                      style: const TextStyle(
                        fontFamily: 'KhmerOS',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    if (isResendDisabled)
                      Text(
                        '$_resendCountdown វិនាទី',
                        style: TextStyle(
                          fontFamily: 'KhmerOS',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryAppColor,
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: () {
                          _startResendTimer();
                          _showSnackBar('បានផ្ញើលេខកូដឡើងវិញ', Colors.blue,
                              Icons.send);
                        },
                        child: Text(
                          'ផ្ញើឡើងវិញ',
                          style: TextStyle(
                            fontFamily: 'KhmerOS',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryAppColor,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 32),

                // Verify Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: isOtpComplete && !_isLoading ? _verifyOtp : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryAppColor,
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
                        : const Text(
                      'ផ្ទៀងផ្ទាត់',
                      style: TextStyle(
                        fontFamily: 'KhmerOS',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Help
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      _showSnackBar(
                        'កំពុងតភ្ជាប់ទៅកាន់សេវាកម្មអតិថិជន...',
                        Colors.blue,
                        Icons.headset_mic,
                      );
                    },
                    icon: const Icon(Icons.help_outline_rounded, size: 18),
                    label: const Text(
                      'ត្រូវការជំនួយ?',
                      style: TextStyle(
                        fontFamily: 'KhmerOS',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}