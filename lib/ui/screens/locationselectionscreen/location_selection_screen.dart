import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_colors.dart';
import 'package:grocery_app/core/models/address_model.dart';
import 'package:grocery_app/routes/app_routes.dart';
import 'package:uuid/uuid.dart';

class LocationSelectionScreen extends StatefulWidget {
  final bool isSignupFlow;
  final AddressModel? initialAddress;

  const LocationSelectionScreen({
    super.key,
    this.isSignupFlow = false,
    this.initialAddress,
  });

  @override
  State<LocationSelectionScreen> createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _houseNoController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Uuid _uuid = const Uuid();

  String? _selectedZone;
  String? _selectedArea;
  bool _isLoadingLocation = false;
  bool _saveAsDefault = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Location data
  final List<String> _zones = [
    'ខណ្ឌចំការមន',
    'ខណ្ឌដូនពេញ',
    'ខណ្ឌទួលគោក',
    'ខណ្ឌសែនសុខ',
    'ខណ្ឌមានជ័យ',
  ];

  final Map<String, List<String>> _areasByZone = {
    'ខណ្ឌចំការមន': ['បឹងកេងកង ១', 'បឹងកេងកង ២', 'ទន្លេបាសាក់'],
    'ខណ្ឌដូនពេញ': ['ផ្សារថ្មី', 'វត្តភ្នំ', 'ជ័យជំនះ'],
    'ខណ្ឌទួលគោក': ['បឹងកក់ ១', 'បឹងកក់ ២', 'ផ្សារដេប៉ូ'],
    'ខណ្ឌសែនសុខ': ['ទឹកថ្លា', 'ខ្មុំ', 'ភ្នំពេញថ្មី'],
    'ខណ្ឌមានជ័យ': ['ស្ទឹងមានជ័យ', 'បឹងតំពែង', 'ចកអង្គរ'],
  };

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();

    if (widget.initialAddress != null) {
      _titleController.text = widget.initialAddress!.title;
      _houseNoController.text = widget.initialAddress!.houseNumber ?? '';
      _streetController.text = widget.initialAddress!.street ?? '';
      _selectedZone = widget.initialAddress!.khan;
      _selectedArea = widget.initialAddress!.sangkat;
      _noteController.text = widget.initialAddress!.note ?? '';
      _saveAsDefault = widget.initialAddress!.isDefault;
    } else {
      _titleController.text = 'ផ្ទះ';
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _titleController.dispose();
    _houseNoController.dispose();
    _streetController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _selectCurrentLocation() async {
    setState(() => _isLoadingLocation = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isLoadingLocation = false;
      _selectedZone = 'ខណ្ឌចំការមន';
      _selectedArea = 'បឹងកេងកង ១';
      _houseNoController.text = '១២៣';
      _titleController.text = 'ទីតាំងបច្ចុប្បន្ន';
      _showSnackBar('ទីតាំងបច្ចុប្បន្នត្រូវបានកំណត់', Colors.green);
    });
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              color == Colors.green ? Icons.check_circle : Icons.info,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontFamily: 'KhmerOS',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        elevation: 4,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _saveLocation() {
    if (!_formKey.currentState!.validate()) {
      _showSnackBar('សូមបំពេញព័ត៌មានគ្រប់ជ្រុងជ្រោយ', Colors.orange);
      return;
    }

    if (_selectedZone == null || _selectedArea == null) {
      _showSnackBar('សូមជ្រើសរើសទីតាំងរបស់អ្នក', Colors.orange);
      return;
    }

    final address = AddressModel(
      id: widget.initialAddress?.id ?? _uuid.v4(),
      title: _titleController.text,
      fullAddress:
      "${_houseNoController.text}${_streetController.text.isNotEmpty ? ', ${_streetController.text}' : ''}, $_selectedArea, $_selectedZone",
      houseNumber: _houseNoController.text.isNotEmpty ? _houseNoController.text : null,
      street: _streetController.text.isNotEmpty ? _streetController.text : null,
      khan: _selectedZone,
      sangkat: _selectedArea,
      note: _noteController.text.isNotEmpty ? _noteController.text : null,
      isDefault: _saveAsDefault,
      createdAt: widget.initialAddress?.createdAt ?? DateTime.now(),
    );

    // Show success animation before navigating
    _showSuccessAnimation(address);
  }

  void _showSuccessAnimation(AddressModel address) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          // 1. Remove fixed height
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16), // 2. Add padding
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // 3. Important: shrink-wrap the content
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60,
              ),
              const SizedBox(height: 20),
              Text(
                'ទីតាំងត្រូវបានរក្សាទុក',
                style: TextStyle(
                  fontFamily: 'KhmerOS',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryAppColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'អ្នកអាចចាប់ផ្ដើមបញ្ជាទិញទំនិញបានឥឡូវនេះ',
                style: const TextStyle(
                  fontFamily: 'KhmerOS',
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24), // Increased spacing before buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12), // Slightly smaller padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: const Text(
                        'កែប្រែបន្ថែម',
                        style: TextStyle(
                          fontFamily: 'KhmerOS',
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (widget.isSignupFlow) {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.signup,
                            arguments: address,
                          );
                        } else {
                          Navigator.pop(context, address);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryAppColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'ប្រើទីតាំងនេះ',
                        style: TextStyle(
                          fontFamily: 'KhmerOS',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.primaryAppColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'KhmerOS',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String hintText = '',
    IconData? prefixIcon,
    Widget? suffixIcon,
    bool isRequired = true,
    int? maxLines,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'KhmerOS',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
              width: 1.5,
            ),
          ),
          child: TextFormField(
            controller: controller,
            style: const TextStyle(
              fontFamily: 'KhmerOS',
              fontSize: 16,
              color: Color(0xFF111827),
            ),
            maxLines: maxLines,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontFamily: 'KhmerOS',
                color: Color(0xFF9CA3AF),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              prefixIcon: prefixIcon != null
                  ? Padding(
                padding: const EdgeInsets.only(left: 16, right: 12),
                child: Icon(
                  prefixIcon,
                  color: const Color(0xFF6B7280),
                  size: 22,
                ),
              )
                  : null,
              suffixIcon: suffixIcon,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
            ),
            validator: isRequired
                ? (value) {
              if (value == null || value.isEmpty) {
                return 'សូមបំពេញព័ត៌មាននេះ';
              }
              return null;
            }
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    IconData? icon,
    bool isRequired = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'KhmerOS',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
              width: 1.5,
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            items: items
                .map(
                  (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontFamily: 'KhmerOS',
                    fontSize: 16,
                  ),
                ),
              ),
            )
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: 'ជ្រើសរើស $label',
              hintStyle: const TextStyle(
                fontFamily: 'KhmerOS',
                color: Color(0xFF9CA3AF),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              prefixIcon: icon != null
                  ? Padding(
                padding: const EdgeInsets.only(left: 16, right: 12),
                child: Icon(
                  icon,
                  color: const Color(0xFF6B7280),
                  size: 22,
                ),
              )
                  : null,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
            ),
            style: const TextStyle(
              fontFamily: 'KhmerOS',
              fontSize: 16,
              color: Color(0xFF111827),
            ),
            icon: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Color(0xFF6B7280),
              ),
            ),
            isExpanded: true,
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(16),
            menuMaxHeight: 300,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom + 20;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF111827),
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.initialAddress != null ? 'កែប្រែទីតាំង' : 'ទីតាំងចែកជូន',
          style: const TextStyle(
            fontFamily: 'KhmerOS',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
        ),
        centerTitle: false,
        actions: [
          if (widget.initialAddress != null)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () {
                _showDeleteConfirmation();
              },
            ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: child,
            ),
          );
        },
        child: Column(
          children: [
            if (widget.isSignupFlow)
              Container(
                height: 4,
                child: LinearProgressIndicator(
                  value: 0.66,
                  backgroundColor: const Color(0xFFF3F4F6),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primaryAppColor,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 8,
                  bottom: bottomPadding + 20, // Add extra space for bottom button
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      // Current Location Card
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1.5,
                          ),
                        ),
                        child: InkWell(
                          onTap: _selectCurrentLocation,
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: _isLoadingLocation
                                          ? [
                                        Colors.blue.shade100,
                                        Colors.blue.shade200
                                      ]
                                          : [
                                        AppColors.primaryAppColor,
                                        AppColors.primaryAppColor
                                            .withOpacity(0.8)
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: _isLoadingLocation
                                        ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        valueColor:
                                        AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                      ),
                                    )
                                        : const Icon(
                                      Icons.my_location_rounded,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ទីតាំងបច្ចុប្បន្ន',
                                        style: const TextStyle(
                                          fontFamily: 'KhmerOS',
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF111827),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'ប្រើទីតាំងបច្ចុប្បន្នរបស់អ្នក',
                                        style: TextStyle(
                                          fontFamily: 'KhmerOS',
                                          fontSize: 14,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: Colors.grey.shade400,
                                  size: 28,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      _buildSectionTitle('ព័ត៌មានទីតាំង'),
                      const SizedBox(height: 16),

                      // Address Type
                      Text(
                        'ប្រភេទទីតាំង',
                        style: const TextStyle(
                          fontFamily: 'KhmerOS',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF374151),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: ['ផ្ទះ', 'ការិយាល័យ', 'ហាង', 'ផ្សេងៗ'].map((type) {
                          final isSelected = _titleController.text == type;
                          return ChoiceChip(
                            label: Text(
                              type,
                              style: TextStyle(
                                fontFamily: 'KhmerOS',
                                color:
                                isSelected ? Colors.white : Colors.grey.shade800,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _titleController.text = type;
                                }
                              });
                            },
                            selectedColor: AppColors.primaryAppColor,
                            backgroundColor: Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: isSelected
                                    ? AppColors.primaryAppColor
                                    : Colors.grey.shade300,
                                width: isSelected ? 0 : 1.5,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),

                      _buildDropdown(
                        label: 'ខណ្ឌ',
                        value: _selectedZone,
                        items: _zones,
                        onChanged: (value) {
                          setState(() {
                            _selectedZone = value;
                            _selectedArea = null;
                          });
                        },
                        icon: Icons.map_rounded,
                      ),
                      const SizedBox(height: 20),

                      _buildDropdown(
                        label: 'សង្កាត់',
                        value: _selectedArea,
                        items: _selectedZone == null
                            ? []
                            : _areasByZone[_selectedZone] ?? [],
                        onChanged: (value) {
                          setState(() => _selectedArea = value);
                        },
                        icon: Icons.location_city_rounded,
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              label: 'លេខផ្ទះ',
                              controller: _houseNoController,
                              hintText: 'លេខ ១២៣',
                              prefixIcon: Icons.numbers_rounded,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              label: 'ផ្លូវ (ជម្រើស)',
                              controller: _streetController,
                              hintText: 'ផ្លូវ ១៥០',
                              prefixIcon: Icons.directions_rounded,
                              isRequired: false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      _buildTextField(
                        label: 'កំណត់ចំណាំ (ជម្រើស)',
                        controller: _noteController,
                        hintText: 'ឧទាហរណ៍៖ ជាន់ទី ២ បន្ទប់ ២០៣',
                        prefixIcon: Icons.note_outlined,
                        isRequired: false,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 24),

                      // Save as default
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: Colors.grey.shade200),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_border_rounded,
                                color: Colors.amber.shade600,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'រក្សាទុកជាទីតាំងលំនាំដើម',
                                      style: const TextStyle(
                                        fontFamily: 'KhmerOS',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF111827),
                                      ),
                                    ),
                                    Text(
                                      'ទីតាំងនេះនឹងត្រូវបានប្រើសម្រាប់ការបញ្ជាទិញទាំងអស់',
                                      style: const TextStyle(
                                        fontFamily: 'KhmerOS',
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: _saveAsDefault,
                                onChanged: (value) {
                                  setState(() => _saveAsDefault = value);
                                },
                                activeColor: AppColors.primaryAppColor,
                                activeTrackColor:
                                AppColors.primaryAppColor.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Info card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade50,
                              Colors.blue.shade100.withOpacity(0.5),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.blue.shade100,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.shade100,
                              ),
                              child: const Icon(
                                Icons.info_outline_rounded,
                                color: Colors.blue,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ព័ត៌មានសំខាន់',
                                    style: TextStyle(
                                      fontFamily: 'KhmerOS',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blue.shade800,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'ទីតាំងត្រឹមត្រូវនឹងជួយឱ្យយើងចែកជូនទំនិញរបស់អ្នកបានលឿនជាងមុន',
                                    style: TextStyle(
                                      fontFamily: 'KhmerOS',
                                      fontSize: 13,
                                      color: Colors.blue.shade700,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40), // Reduced from 100 to 40
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 30,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                  ),
                ),
                child: Text(
                  'បោះបង់',
                  style: TextStyle(
                    fontFamily: 'KhmerOS',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: _saveLocation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryAppColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                  shadowColor: AppColors.primaryAppColor.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on_outlined, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      widget.isSignupFlow
                          ? 'បន្តទៅការចុះឈ្មោះ'
                          : 'រក្សាទុកទីតាំង',
                      style: const TextStyle(
                        fontFamily: 'KhmerOS',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
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

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'លុបទីតាំងនេះ?',
          style: TextStyle(
            fontFamily: 'KhmerOS',
            color: Colors.red.shade700,
          ),
        ),
        content: Text(
          'អ្នកពិតជាចង់លុបទីតាំងនេះឬ? សកម្មភាពនេះមិនអាចដកថយបានទេ។',
          style: const TextStyle(fontFamily: 'KhmerOS'),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'បោះបង់',
              style: TextStyle(
                fontFamily: 'KhmerOS',
                color: Colors.grey.shade700,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, null);
              _showSnackBar('ទីតាំងត្រូវបានលុបដោយជោគជ័យ', Colors.red);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'លុប',
              style: TextStyle(
                fontFamily: 'KhmerOS',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}