import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grocery_app/core/constants/app_colors.dart';

class MyDetailScreen extends StatefulWidget {
  const MyDetailScreen({super.key});

  @override
  State<MyDetailScreen> createState() => _MyDetailScreenState();
}

class _MyDetailScreenState extends State<MyDetailScreen> {
  // User data variables
  String name = "Chhin Daro";
  String email = "daro.cambodia@gmail.com";
  String phoneNumber = "+855 12 345 678";
  dynamic profileImage = 'assets/images/account/profile.jpg';

  // Edit mode variables
  bool isEditMode = false;
  File? _tempImage;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current values
    _nameController.text = name;
    _emailController.text = email;
    _phoneController.text = phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: _buildAppBar(),
      body: isEditMode ? _buildEditBody() : _buildViewBody(),
    );
  }

  // AppBar with dynamic title based on mode
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundWhite,
      elevation: 0,
      leading: isEditMode
          ? IconButton(
        icon: const Icon(Icons.close, color: Colors.black),
        onPressed: _cancelEdit,
      )
          : const BackButton(color: Colors.black),
      title: Text(
        isEditMode ? "កែព័ត៌មានអ្នកប្រើប្រាស់" : "ព័ត៌មានអ្នកប្រើប្រាស់",
        style: const TextStyle(
          fontFamily: 'KhmerOS',
          color: AppColors.primaryTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      actions: isEditMode
          ? [
        TextButton(
          onPressed: _saveChanges,
          child: const Text(
            "រក្សាទុក",
            style: TextStyle(
              fontFamily: 'KhmerOS',
              color: AppColors.primaryAppColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
      ]
          : null,
    );
  }

  // View Mode Body
  Widget _buildViewBody() {
    return Column(
      children: [
        const SizedBox(height: 30),
        _buildProfileHeader(isEditable: false),
        const SizedBox(height: 40),
        _buildInfoTile(Icons.person_outline, "ឈ្មោះ", name),
        _buildInfoTile(Icons.email_outlined, "អ៊ីមែល", email),
        _buildInfoTile(Icons.phone_android_outlined, "លេខទូរស័ព្ទ", phoneNumber),
        const Spacer(),
        _buildEditButton(),
      ],
    );
  }

  // Edit Mode Body
  Widget _buildEditBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        children: [
          _buildProfileHeader(isEditable: true),
          const SizedBox(height: 40),
          _buildInputField(
            "ឈ្មោះ",
            _nameController,
            Icons.person_outline,
            "បញ្ចូលឈ្មោះរបស់អ្នក",
            TextInputType.name,
          ),
          const SizedBox(height: 20),
          _buildInputField(
            "អ៊ីមែល",
            _emailController,
            Icons.email_outlined,
            "បញ្ចូលអ៊ីមែលរបស់អ្នក",
            TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          _buildInputField(
            "លេខទូរស័ព្ទ",
            _phoneController,
            Icons.phone_android_outlined,
            "បញ្ចូលលេខទូរស័ព្ទ",
            TextInputType.phone,
          ),
          const SizedBox(height: 50),
          _buildSaveButton(),
        ],
      ),
    );
  }

  // Profile Header (works for both modes)
  Widget _buildProfileHeader({required bool isEditable}) {
    return Column(
      children: [
        GestureDetector(
          onTap: isEditable ? _pickImage : null,
          child: Stack(
            alignment: isEditable ? Alignment.bottomRight : Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryAppColor.withOpacity(0.2),
                    width: 5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _getProfileImage(),
                  child: isEditable && _tempImage == null && profileImage is String
                      ? const Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                      : null,
                ),
              ),
              if (isEditable)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryAppColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 20),
                ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        isEditMode
            ? Container() // Hide name/email in edit mode (shown in text fields)
            : Column(
          children: [
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'KhmerOS',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryTextColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              email,
              style: const TextStyle(
                fontFamily: 'KhmerOS',
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Helper method to get profile image
  ImageProvider _getProfileImage() {
    if (_tempImage != null) {
      return FileImage(_tempImage!);
    } else if (profileImage is File) {
      return FileImage(profileImage as File);
    } else if (profileImage is String) {
      return AssetImage(profileImage as String);
    }
    return const AssetImage('assets/images/account/profile.jpg');
  }

  // Info Tile for View Mode
  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryAppColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primaryAppColor, size: 26),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'KhmerOS',
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'KhmerOS',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.primaryTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Input Field for Edit Mode
  Widget _buildInputField(
      String label,
      TextEditingController controller,
      IconData icon,
      String hint,
      TextInputType type,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'KhmerOS',
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: type,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontFamily: 'KhmerOS'),
              prefixIcon: Icon(icon, color: AppColors.primaryAppColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[50],
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
            ),
          ),
        ),
      ],
    );
  }

  // Edit Button (View Mode)
  Widget _buildEditButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isEditMode = true;
                _tempImage = null; // Reset temporary image
              });
            },
            style: ElevatedButton.styleFrom(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
            ).copyWith(
              shadowColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryAppColor, Color(0xFF4A90E2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Center(
                child: Text(
                  "កែព័ត៌មាន",
                  style: TextStyle(
                    fontFamily: 'KhmerOS',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Save Button (Edit Mode)
  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: _saveChanges,
        style: ElevatedButton.styleFrom(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
        ).copyWith(
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primaryAppColor, Color(0xFF4A90E2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Center(
            child: Text(
              "រក្សាទុកការផ្លាស់ប្តូរ",
              style: TextStyle(
                fontFamily: 'KhmerOS',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Image Picker
  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _tempImage = File(pickedFile.path);
      });
    }
  }

  // Show Message/Snackbar
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

  // Save Changes
  void _saveChanges() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      _showMessage("សូមបញ្ចូលព័ត៍មានទាំងអស់ ❌", Colors.red);
      return;
    }

    if (!_emailController.text.contains('@')) {
      _showMessage("សូមបញ្ចូលអ៊ីមែលត្រឹមត្រូវ ❌", Colors.red);
      return;
    }

    // Update user data
    setState(() {
      name = _nameController.text;
      email = _emailController.text;
      phoneNumber = _phoneController.text;

      // Update profile image if a new one was picked
      if (_tempImage != null) {
        profileImage = _tempImage;
      }

      // Reset temporary image
      _tempImage = null;
    });

    _showMessage("ព័ត៌មានអ្នកប្រើប្រាស់បានរក្សាទុក 🎉", Colors.green);

    // Switch back to view mode
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        isEditMode = false;
      });
    });
  }

  // Cancel Edit
  void _cancelEdit() {
    setState(() {
      isEditMode = false;
      _tempImage = null; // Discard any temporary image
      // Reset controllers to original values
      _nameController.text = name;
      _emailController.text = email;
      _phoneController.text = phoneNumber;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}