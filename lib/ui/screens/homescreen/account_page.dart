import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_colors.dart';
import 'package:grocery_app/routes/app_routes.dart';
import 'package:grocery_app/ui/screens/homescreen/account/about_screen.dart';
import 'package:grocery_app/ui/screens/homescreen/account/mydetail_screen.dart';
import 'package:grocery_app/ui/screens/homescreen/account/orders_screen.dart';
import 'package:grocery_app/ui/screens/homescreen/account/help_screen.dart';
import 'package:grocery_app/ui/screens/homescreen/account/notification_screen.dart';
import 'package:grocery_app/ui/screens/homescreen/account/delivery_address_screen.dart';
import 'package:grocery_app/ui/screens/homescreen/account/payment_method_screen.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // --- Profile Header Card ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 35,
                        backgroundImage:
                        AssetImage('assets/images/account/profile.jpg'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Chhin Daro",
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'KhmerOS', // <-- KhmerOS
                          ),
                        ),
                        Text(
                          "daro.cambodia@gmail.com",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontFamily: 'KhmerOS', // <-- KhmerOS
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // --- Menu List ---
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _accountTile(Icons.shopping_bag_outlined, "ការបញ្ជាទិញ", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const OrdersScreen()),
                    );
                  }),
                  _accountTile(Icons.badge_outlined, "ព័ត៌មានផ្ទាល់ខ្លួន", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MyDetailScreen()),
                    );
                  }),
                  _accountTile(Icons.location_on_outlined, "អាសយដ្ឋានដឹកជញ្ជូន", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DeliveryAddressScreen()),
                    );
                  }),
                  _accountTile(Icons.credit_card, "វិធីសាស្រ្តបង់ប្រាក់", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PaymentMethodScreen()),
                    );
                  }),
                  _accountTile(Icons.notifications_none, "ការជូនដំណឹង", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                    );
                  }),
                  _accountTile(Icons.help_outline, "ជំនួយ", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HelpPage()),
                    );
                  }),
                  _accountTile(Icons.info_outline, "អំពី", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AboutScreen()),
                    );
                  }),
                ],
              ),
            ),

            // --- Logout Button ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.loginAccount, (route) => false);
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
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.logout, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            "ចាកចេញ", // Khmer for "Log Out"
                            style: TextStyle(
                              fontFamily: 'KhmerOS', // <-- KhmerOS
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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

  Widget _accountTile(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
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
              Icon(icon, color: AppColors.primaryAppColor, size: 28),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'KhmerOS', // <-- KhmerOS
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
