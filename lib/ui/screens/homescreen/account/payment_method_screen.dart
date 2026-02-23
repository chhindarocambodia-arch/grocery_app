import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_colors.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int selectedCardIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "វិធីសាស្រ្តទូទាត់", // Khmer for "Payment Methods"
          style: TextStyle(
            fontFamily: 'KhmerOS',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "កាតដែលបានរក្សាទុក", // Khmer for "Saved Cards"
              style: TextStyle(
                fontFamily: 'KhmerOS',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 14),

            _paymentTile(
              index: 0,
              icon: Icons.credit_card,
              title: "Visa ចុងក្រោយ 4242",
              subtitle: "ផុតកំណត់ 12/26",
            ),
            _paymentTile(
              index: 1,
              icon: Icons.credit_card,
              title: "Mastercard ចុងក្រោយ 8888",
              subtitle: "ផុតកំណត់ 05/28",
            ),

            const SizedBox(height: 28),
            const Text(
              "វិធីផ្សេងទៀត", // Khmer for "Other Methods"
              style: TextStyle(
                fontFamily: 'KhmerOS',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 14),

            _paymentTile(
              index: 2,
              icon: Icons.account_balance_wallet_outlined,
              title: "ABA PAY",
              subtitle: "បានភ្ជាប់",
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "បានផ្ទៀងផ្ទាត់", // Khmer for "Verified"
                  style: TextStyle(
                    fontFamily: 'KhmerOS',
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const Spacer(),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add new method action
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(0),
                    ).copyWith(
                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                      shadowColor: MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primaryAppColor, Color(0xFF4A90E2)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "បន្ថែមវិធីថ្មី", // Khmer for "Add New Method"
                          style: TextStyle(
                            fontFamily: 'KhmerOS',
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentTile({
    required int index,
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
  }) {
    final bool selected = selectedCardIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCardIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: selected
              ? [
            BoxShadow(
              color: AppColors.primaryAppColor.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ]
              : [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: selected ? AppColors.primaryAppColor : Colors.transparent,
            width: selected ? 1.5 : 0,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          leading: Icon(
            icon,
            color: selected ? AppColors.primaryAppColor : Colors.black87,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'KhmerOS',
              fontWeight: FontWeight.w600,
              color: selected ? AppColors.primaryAppColor : Colors.black87,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontFamily: 'KhmerOS',
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          trailing: trailing ??
              (selected
                  ? Icon(Icons.check_circle, color: AppColors.primaryAppColor)
                  : const Icon(Icons.chevron_right, color: Colors.grey)),
        ),
      ),
    );
  }
}
