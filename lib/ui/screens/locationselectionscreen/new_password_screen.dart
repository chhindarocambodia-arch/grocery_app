import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_colors.dart';
import 'package:grocery_app/routes/app_routes.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isConfirmHidden = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primaryAppColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.primaryAppColor,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "បានកំណត់ពាក្យសម្ងាត់ថ្មី!",
                style: TextStyle(
                  fontFamily: 'KhmerOS',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                "ពាក្យសម្ងាត់របស់អ្នកត្រូវបានកំណត់ដោយជោគជ័យ។",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'KhmerOS',
                  fontSize: 14,
                  color: Color(0xFF757575),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.loginAccount, (route) => false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryAppColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "ចូលគណនី",
                    style: TextStyle(
                      fontFamily: 'KhmerOS',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback toggleVisibility,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'KhmerOS',
            color: Color(0xFF424242),
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            style: const TextStyle(
              fontFamily: 'KhmerOS',
              fontSize: 16,
              color: Color(0xFF212121),
            ),
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: const Icon(Icons.lock_outline_rounded,
                    color: AppColors.primaryAppColor),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                onPressed: toggleVisibility,
              ),
              hintText: "បញ្ចូល$label",
              hintStyle: const TextStyle(
                fontFamily: 'KhmerOS',
                color: Color(0xFF9E9E9E),
              ),
              border: InputBorder.none,
              contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              isDense: true,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _handleSetPassword() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API call
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() => _isLoading = false);
          _showSuccessDialog();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      size: 20, color: Color(0xFF212121)),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 20),

                // Illustration
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryAppColor.withOpacity(0.1),
                          Colors.blue.shade50,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.key_rounded,
                      size: 60,
                      color: AppColors.primaryAppColor,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ពាក្យសម្ងាត់ថ្មី',
                      style: TextStyle(
                        fontFamily: 'KhmerOS',
                        fontSize: 24,
                        color: Color(0xFF212121),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'បញ្ចូលពាក្យសម្ងាត់ថ្មីរបស់អ្នក និងបញ្ជាក់ម្តងទៀត',
                      style: TextStyle(
                        fontFamily: 'KhmerOS',
                        fontSize: 14,
                        color: Color(0xFF757575),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildPasswordField(
                        label: "ពាក្យសម្ងាត់",
                        controller: _passController,
                        obscureText: _isPasswordHidden,
                        toggleVisibility: () =>
                            setState(() => _isPasswordHidden = !_isPasswordHidden),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ត្រូវការពាក្យសម្ងាត់';
                          }
                          if (value.length < 6) {
                            return 'ពាក្យសម្ងាត់ត្រូវមានយ៉ាងតិច ៦ តួអក្សរ';
                          }
                          return null;
                        },
                      ),
                      _buildPasswordField(
                        label: "បញ្ជាក់ពាក្យសម្ងាត់",
                        controller: _confirmPassController,
                        obscureText: _isConfirmHidden,
                        toggleVisibility: () =>
                            setState(() => _isConfirmHidden = !_isConfirmHidden),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ត្រូវការបញ្ជាក់ពាក្យសម្ងាត់';
                          }
                          if (value != _passController.text) {
                            return 'ពាក្យសម្ងាត់មិនត្រូវគ្នា';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Set Password Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSetPassword,
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
                              : const Text(
                            'កំណត់ពាក្យសម្ងាត់',
                            style: TextStyle(
                              fontFamily: 'KhmerOS',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Back to login
                      Center(
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamedAndRemoveUntil(
                              context, AppRoutes.loginAccount, (route) => false),
                          child: const Text(
                            "ត្រឡប់ទៅចូលគណនី",
                            style: TextStyle(
                              fontFamily: 'KhmerOS',
                              color: AppColors.primaryAppColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
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