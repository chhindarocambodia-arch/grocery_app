import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/core/constants/app_colors.dart';
import 'package:grocery_app/core/models/product_model.dart';
import 'package:grocery_app/ui/screens/homescreen/checkout_bottom_sheet.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double get _totalPrice => globalCartList.fold(
    0,
        (sum, item) => sum + (item.product.price * item.quantity),
  );

  void _removeItem(int index) {
    final removedItem = globalCartList[index];
    setState(() => globalCartList.removeAt(index));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${removedItem.product.name} ត្រូវបានលុបចេញកាត",
            style: const TextStyle(fontFamily: 'KhmerOS')),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () => setState(() => globalCartList.insert(index, removedItem)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "កាត់របស់ខ្ញុំ", // "My Cart" in Khmer
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              fontFamily: 'KhmerOS'),
        ),
      ),
      body: globalCartList.isEmpty
          ? _buildEmptyCart()
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: globalCartList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Dismissible(
                  key: ValueKey(globalCartList[index].product.name),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete_outline,
                        color: Colors.white, size: 30),
                  ),
                  onDismissed: (_) => _removeItem(index),
                  child: _CartItemCard(
                    cartItem: globalCartList[index],
                    onRemove: () => _removeItem(index),
                    onQuantityChange: () => setState(() {}),
                  ),
                ),
              ),
            ),
          ),
          _buildCheckoutButton(),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 15, 25, 25),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 70,
          child: ElevatedButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => CheckoutBottomSheet(total: _totalPrice),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 6,
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
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "ទៅដល់ការទូទាត់", // "Go to Checkout"
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'KhmerOS',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "\$${_totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'KhmerOS',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 90, color: Colors.grey[300]),
          const SizedBox(height: 20),
          const Text(
            "កាត់របស់អ្នកទទេ 😔", // "Your cart is empty"
            style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'KhmerOS'),
          ),
        ],
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onRemove;
  final VoidCallback onQuantityChange;

  const _CartItemCard({
    required this.cartItem,
    required this.onRemove,
    required this.onQuantityChange,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(cartItem.product.imageUrl,
                width: 70, height: 70, fit: BoxFit.contain),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cartItem.product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'KhmerOS')),
                Text("${cartItem.product.weight} • \$${cartItem.product.price}",
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 14, fontFamily: 'KhmerOS')),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _QuantityButton(
                        icon: Icons.remove,
                        onTap: () {
                          if (cartItem.quantity > 1) {
                            cartItem.quantity--;
                            onQuantityChange();
                          }
                        }),
                    Container(
                      width: 35,
                      alignment: Alignment.center,
                      child: Text("${cartItem.quantity}",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'KhmerOS')),
                    ),
                    _QuantityButton(
                        icon: Icons.add,
                        onTap: () {
                          cartItem.quantity++;
                          onQuantityChange();
                        },
                        isPrimary: true),
                    const Spacer(),
                    Text(
                        "\$${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}",
                        style: const TextStyle(
                            color: AppColors.primaryAppColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'KhmerOS')),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _QuantityButton({
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isPrimary
              ? AppColors.primaryAppColor.withOpacity(0.15)
              : Colors.grey[100],
          border: Border.all(
            color: isPrimary
                ? AppColors.primaryAppColor.withOpacity(0.3)
                : Colors.grey[300]!,
          ),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isPrimary ? AppColors.primaryAppColor : Colors.grey[600],
        ),
      ),
    );
  }
}
