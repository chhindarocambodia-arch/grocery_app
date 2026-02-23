import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_colors.dart';
import 'package:grocery_app/ui/screens/homescreen/account/delivery_address_screen.dart';
import 'package:grocery_app/ui/screens/homescreen/account/payment_method_screen.dart';
import 'package:grocery_app/ui/screens/homescreen/order_accepted_screen.dart';

class CheckoutBottomSheet extends StatefulWidget {
  final double total;
  const CheckoutBottomSheet({super.key, required this.total});

  @override
  State<CheckoutBottomSheet> createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  String selectedAddress = "ផ្ទះ"; // "Home" in Khmer
  String selectedPayment = "Visa បញ្ចប់ដោយ 4242";

  void _showOrderAccepted(BuildContext context) {
    Navigator.pop(context); // close bottom sheet
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const OrderAcceptedScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "បង់ទំនិញ", // "Checkout" in Khmer
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'KhmerOS'),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Delivery Row
          _cardRow(
            title: "ការដឹកជញ្ជូន",
            value: selectedAddress,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DeliveryAddressScreen()),
            ),
          ),
          const SizedBox(height: 12),

          // Payment Row
          _cardRow(
            title: "វិធីបង់ប្រាក់",
            value: selectedPayment,
            icon: Icons.credit_card,
            iconColor: Colors.blue,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PaymentMethodScreen()),
            ),
          ),
          const SizedBox(height: 12),

          // Total Cost
          _cardRow(
            title: "តម្លៃសរុប",
            value: "\$${widget.total.toStringAsFixed(2)}",
          ),
          const SizedBox(height: 20),

          _buildTermsText(),
          const SizedBox(height: 25),

          _buildOrderButton(context),
        ],
      ),
    );
  }

  Widget _cardRow({
    required String title,
    required String value,
    IconData? icon,
    Color? iconColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: iconColor ?? Colors.black54, size: 22),
              const SizedBox(width: 10),
            ],
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontFamily: 'KhmerOS',
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontFamily: 'KhmerOS',
              ),
            ),
            if (onTap != null) ...[
              const SizedBox(width: 10),
              const Icon(Icons.chevron_right, color: Colors.black54, size: 24),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTermsText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text.rich(
        TextSpan(
          text: "ដោយការបញ្ជាទិញ អ្នកយល់ព្រមលក្ខខណ្ឌ និង ",
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontFamily: 'KhmerOS',
          ),
          children: const [
            TextSpan(
                text: "លក្ខខណ្ឌ",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderButton(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: 65,
        child: ElevatedButton(
          onPressed: () => _showOrderAccepted(context),
          style: ElevatedButton.styleFrom(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.primaryAppColor,
                  Color(0xFF4A90E2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "បញ្ជាទិញ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'KhmerOS',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
