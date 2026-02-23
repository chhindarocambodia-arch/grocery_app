import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:grocery_app/core/constants/app_colors.dart';
import 'package:grocery_app/core/models/address_model.dart';
import 'package:grocery_app/core/themes/app_theme.dart';
import 'package:grocery_app/routes/app_routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _agreeToTerms = false;

  late TapGestureRecognizer _termsRecognizer;
  late TapGestureRecognizer _privacyRecognizer;

  @override
  void initState() {
    super.initState();
    _termsRecognizer = TapGestureRecognizer()
      ..onTap = () => _showMessage("សន្ទនាអំពីលក្ខខណ្ឌ", Colors.blue);
    _privacyRecognizer = TapGestureRecognizer()
      ..onTap = () => _showMessage("គោលការណ៍ភាពឯកជន", Colors.blue);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'KhmerOS'),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? hint,
    required TextEditingController controller,
    bool obscure = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.secondaryTextColor,
            fontWeight: FontWeight.w600,
            fontFamily: 'KhmerOS',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF2F3F2),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscure,
            keyboardType: keyboardType,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontFamily: 'KhmerOS'),
              border: InputBorder.none,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              suffixIcon: suffixIcon,
            ),
            style: const TextStyle(fontFamily: 'KhmerOS'),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _handleSignUp(AddressModel? selectedAddress) {
    if (!_agreeToTerms) {
      _showMessage("សូមទទួលស្គាល់លក្ខខណ្ឌ និងលក្ខខណ្ឌ", Colors.orange);
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedAddress == null) {
      _showMessage("សូមជ្រើសរើសទីតាំងរបស់អ្នក", Colors.red);
      return;
    }

    _showMessage("បង្កើតគណនីដោយជោគជ័យ 🎉", Colors.green);

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
            (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Gradient buttonGradient = const LinearGradient(
      colors: [AppColors.primaryAppColor, Color(0xFF4A90E2)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final AddressModel? selectedAddress =
    ModalRoute.of(context)?.settings.arguments as AddressModel?;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'បង្កើតគណនី',
                  style: AppTheme.headlineStyle
                      .copyWith(fontSize: 28, fontFamily: 'KhmerOS'),
                ),
                const SizedBox(height: 6),
                const Text(
                  'បញ្ចូលព័ត៌មានរបស់អ្នកដើម្បីបន្ត',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryTextColor,
                    fontFamily: 'KhmerOS',
                  ),
                ),
                const SizedBox(height: 30),

                _buildTextField(
                  label: 'ឈ្មោះអ្នកប្រើប្រាស់',
                  hint: 'បញ្ចូលឈ្មោះអ្នកប្រើប្រាស់',
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "សូមបញ្ចូលឈ្មោះអ្នកប្រើប្រាស់";
                    }
                    if (value.length < 3) {
                      return "ឈ្មោះត្រូវតែមានយ៉ាងហោចណាស់ 3 តួអក្សរ";
                    }
                    return null;
                  },
                ),

                _buildTextField(
                  label: 'អ៊ីមែល',
                  hint: 'បញ្ចូលអ៊ីមែល',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "សូមបញ្ចូលអ៊ីមែល";
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return "សូមបញ្ចូលអ៊ីមែលត្រឹមត្រូវ";
                    }
                    return null;
                  },
                ),

                _buildTextField(
                  label: 'ពាក្យសម្ងាត់',
                  hint: 'បញ្ចូលពាក្យសម្ងាត់',
                  controller: _passwordController,
                  obscure: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "សូមបញ្ចូលពាក្យសម្ងាត់";
                    }
                    if (value.length < 6) {
                      return "ពាក្យសម្ងាត់ត្រូវមានយ៉ាងតិច 6 តួអក្សរ";
                    }
                    return null;
                  },
                  suffixIcon: GestureDetector(
                    onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),

                // Address Section
                if (selectedAddress != null) ...[
                  const SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Icon(Icons.location_on,
                              color: AppColors.primaryAppColor),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedAddress.title,
                                  style: const TextStyle(
                                    fontFamily: 'KhmerOS',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  selectedAddress.fullAddress,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'KhmerOS',
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit_outlined),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.locationSelection,
                                arguments: true,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ] else ...[
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.locationSelection,
                          arguments: true,
                        );
                      },
                      icon: const Icon(Icons.add_location_alt_outlined),
                      label: const Text(
                        'ជ្រើសរើសទីតាំង',
                        style: TextStyle(fontFamily: 'KhmerOS'),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: BorderSide(color: AppColors.primaryAppColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // Terms and Conditions
                Row(
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      onChanged: (value) => setState(() => _agreeToTerms = value!),
                      activeColor: AppColors.primaryAppColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'KhmerOS',
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          children: [
                            const TextSpan(text: "ខ្ញុំយល់ព្រមជាមួយ "),
                            TextSpan(
                              text: "លក្ខខណ្ឌ",
                              style: const TextStyle(
                                color: AppColors.primaryAppColor,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: _termsRecognizer,
                            ),
                            const TextSpan(text: " និង "),
                            TextSpan(
                              text: "គោលការណ៍ភាពឯកជន",
                              style: const TextStyle(
                                color: AppColors.primaryAppColor,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: _privacyRecognizer,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () => _handleSignUp(selectedAddress),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.transparent,
                      elevation: 6,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: buttonGradient,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          'ចុះឈ្មោះ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'KhmerOS',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'KhmerOS',
                      ),
                      children: [
                        const TextSpan(text: 'មានគណនីរួចហើយ? '),
                        TextSpan(
                          text: 'ចូល',
                          style: const TextStyle(color: AppColors.primaryAppColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, AppRoutes.loginAccount);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}