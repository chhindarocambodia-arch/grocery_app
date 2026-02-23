import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_colors.dart';
import 'package:grocery_app/core/models/address_model.dart';
import 'package:grocery_app/ui/screens/locationselectionscreen/location_selection_screen.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({super.key});

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen>
    with SingleTickerProviderStateMixin {
  String? _selectedAddressId;
  List<AddressModel> addresses = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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

    _animationController.forward();

    // Load sample addresses
    _loadAddresses();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadAddresses() {
    // Simulate loading addresses
    setState(() {
      addresses = [
        AddressModel(
          id: '1',
          title: 'ផ្ទះ',
          fullAddress: 'ផ្ទះលេខ ១២៣, ផ្លូវ ១៥០, សង្កាត់បឹងកេងកង ១, ខណ្ឌចំការមន',
          houseNumber: 'ផ្ទះលេខ ១២៣',
          street: 'ផ្លូវ ១៥០',
          khan: 'ខណ្ឌចំការមន',
          sangkat: 'សង្កាត់បឹងកេងកង ១',
          note: 'ជាន់ទី ២, ឆ្វេងដៃ',
          isDefault: true,
        ),
        AddressModel(
          id: '2',
          title: 'ការិយាល័យ',
          fullAddress: 'តួអគារលេខ ២០១, ផ្លូវមួយសែន, សង្កាត់វត្តភ្នំ, ខណ្ឌដូនពេញ',
          houseNumber: 'តួអគារលេខ ២០១',
          street: 'ផ្លូវមួយសែន',
          khan: 'ខណ្ឌដូនពេញ',
          sangkat: 'សង្កាត់វត្តភ្នំ',
          note: 'ការិយាល័យជាន់ទី ៥',
          isDefault: false,
        ),
      ];
      _selectedAddressId = addresses.firstWhere((addr) => addr.isDefault).id;
    });
  }

  Future<void> _addNewAddress() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LocationSelectionScreen(
          isSignupFlow: false,
        ),
      ),
    );

    if (result != null && result is AddressModel) {
      setState(() => addresses.add(result));
      _showSnackBar('អាសយដ្ឋានថ្មីត្រូវបានបន្ថែម', Colors.green);
    }
  }

  Future<void> _editAddress(AddressModel address) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LocationSelectionScreen(
          isSignupFlow: false,
          initialAddress: address,
        ),
      ),
    );

    if (result != null && result is AddressModel) {
      final index = addresses.indexWhere((a) => a.id == address.id);
      if (index != -1) {
        setState(() => addresses[index] = result);
        _showSnackBar('អាសយដ្ឋានត្រូវបានកែប្រែ', Colors.blue);
      }
    }
  }

  Future<void> _deleteAddress(String addressId) async {
    final address = addresses.firstWhere((a) => a.id == addressId);

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'លុបអាសយដ្ឋាននេះ?',
          style: TextStyle(
            fontFamily: 'KhmerOS',
            color: Colors.red,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'អ្នកពិតជាចង់លុបអាសយដ្ឋាន "${address.title}" ឬ? សកម្មភាពនេះមិនអាចត្រឡប់វិញបានទេ។',
          style: const TextStyle(fontFamily: 'KhmerOS'),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'បោះបង់',
              style: TextStyle(
                fontFamily: 'KhmerOS',
                color: Colors.grey,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
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

    if (confirmed == true) {
      setState(() {
        addresses.removeWhere((a) => a.id == addressId);
        if (_selectedAddressId == addressId && addresses.isNotEmpty) {
          _selectedAddressId = addresses.first.id;
        }
      });
      _showSnackBar('អាសយដ្ឋានត្រូវបានលុប', Colors.red);
    }
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
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildAddressTile(AddressModel address) {
    final isSelected = _selectedAddressId == address.id;
    final isDefault = address.isDefault;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedAddressId = address.id);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryAppColor.withOpacity(0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryAppColor
                : Colors.grey.shade200,
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isSelected ? 0.05 : 0.03),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? AppColors.primaryAppColor
                              : Colors.grey.shade100,
                        ),
                        child: Icon(
                          _getAddressIcon(address.title),
                          color: isSelected ? Colors.white : Colors.grey.shade600,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  address.title,
                                  style: TextStyle(
                                    fontFamily: 'KhmerOS',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: isSelected
                                        ? AppColors.primaryAppColor
                                        : const Color(0xFF111827),
                                  ),
                                ),
                                if (isDefault) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.amber,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color: Colors.amber.shade700,
                                          size: 14,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'លំនាំដើម',
                                          style: TextStyle(
                                            fontFamily: 'KhmerOS',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.amber.shade800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              address.fullAddress,
                              style: const TextStyle(
                                fontFamily: 'KhmerOS',
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                                height: 1.5,
                              ),
                            ),
                            if (address.note != null && address.note!.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.blue.shade100,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.note_outlined,
                                      color: Colors.blue.shade600,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        address.note!,
                                        style: TextStyle(
                                          fontFamily: 'KhmerOS',
                                          fontSize: 13,
                                          color: Colors.blue.shade800,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _editAddress(address),
                          icon: const Icon(Icons.edit_rounded, size: 18),
                          label: const Text(
                            'កែប្រែ',
                            style: TextStyle(
                              fontFamily: 'KhmerOS',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.blue.shade700,
                            side: BorderSide(color: Colors.blue.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _deleteAddress(address.id),
                          icon: const Icon(Icons.delete_outline_rounded, size: 18),
                          label: const Text(
                            'លុប',
                            style: TextStyle(
                              fontFamily: 'KhmerOS',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red.shade700,
                            side: BorderSide(color: Colors.red.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isSelected)
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryAppColor,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getAddressIcon(String title) {
    switch (title) {
      case 'ផ្ទះ':
        return Icons.home_rounded;
      case 'ការិយាល័យ':
        return Icons.business_rounded;
      case 'ហាង':
        return Icons.store_rounded;
      default:
        return Icons.location_on_rounded;
    }
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade100,
          ),
          child: const Icon(
            Icons.location_off_rounded,
            color: Colors.grey,
            size: 50,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'មិនទាន់មានអាសយដ្ឋានទេ',
          style: TextStyle(
            fontFamily: 'KhmerOS',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'បន្ថែមអាសយដ្ឋានដំបូងរបស់អ្នកដើម្បីចាប់ផ្តើមទទួលការចែកជូនទំនិញ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'KhmerOS',
              fontSize: 15,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          'អាសយដ្ឋានចែកជូន',
          style: TextStyle(
            fontFamily: 'KhmerOS',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.help_outline_rounded,
              color: Color(0xFF6B7280),
            ),
            onPressed: () {
              // Show help dialog
              _showSnackBar('ជ្រើសរើសអាសយដ្ឋានសម្រាប់ការចែកជូនទំនិញ', Colors.blue);
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: child,
          );
        },
        child: Column(
          children: [
            // Info card
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade50,
                    Colors.blue.shade100.withOpacity(0.3),
                  ],
                ),
                border: Border.all(
                  color: Colors.blue.shade200,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade100,
                    ),
                    child: const Icon(
                      Icons.local_shipping_rounded,
                      color: Colors.blue,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ព័ត៌មានសំខាន់',
                          style: TextStyle(
                            fontFamily: 'KhmerOS',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue.shade800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'អាសយដ្ឋានត្រឹមត្រូវនឹងជួយឱ្យការចែកជូនមានលក្ខណៈរហ័សរហួន',
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

            // Addresses list or empty state
            Expanded(
              child: addresses.isEmpty
                  ? _buildEmptyState()
                  : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    ...addresses.map((address) => _buildAddressTile(address)),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),

            // Bottom action bar
            // Bottom action bar
            Container(
              padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Primary Action: Use Selected Address
                  if (_selectedAddressId != null && addresses.isNotEmpty)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final address = addresses.firstWhere((a) => a.id == _selectedAddressId);
                          Navigator.pop(context, address);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryAppColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                        child: const Text(
                          'ប្រើអាសយដ្ឋាននេះ',
                          style: TextStyle(
                            fontFamily: 'KhmerOS',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  // Secondary Action: Add New
                  SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: _addNewAddress,
                      icon: const Icon(Icons.add_circle_outline_rounded),
                      label: const Text(
                        'បន្ថែមអាសយដ្ឋានថ្មី',
                        style: TextStyle(
                          fontFamily: 'KhmerOS',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primaryAppColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}