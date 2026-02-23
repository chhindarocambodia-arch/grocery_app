import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_colors.dart';
import 'package:grocery_app/core/models/order_item_model.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final List<OrderItem> orders = [
    OrderItem(
      productId: "p1",
      name: "Sprite Can",
      weight: "325ml",
      price: 1.50,
      date: "17-Dec-2025",
      imagePath: "assets/images/account/orders/SpriteCan.png",
      rating: 3,
      status: "Delivered",
    ),
    OrderItem(
      productId: "p2",
      name: "Diet Coke",
      weight: "355ml",
      price: 1.99,
      date: "18-Dec-2025",
      imagePath: "assets/images/account/orders/diet_coke.png",
      rating: 5,
      status: "Delivered",
    ),
    OrderItem(
      productId: "p3",
      name: "Apple & Grape Juice",
      weight: "2L",
      price: 15.50,
      date: "19-Dec-2025",
      imagePath: "assets/images/account/orders/juice.png",
      rating: 4,
      status: "Processing",
    ),
  ];

  void _showReorderBottomSheet(OrderItem item, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReorderBottomSheet(item: item),
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
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "ការបញ្ជាទិញរបស់ខ្ញុំ",
          style: TextStyle(
            fontFamily: 'KhmerOS',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: orders.length,
        itemBuilder: (context, index) => _buildOrderCard(context, orders[index]),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE2E2E2).withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F3F2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(item.imagePath, fit: BoxFit.contain),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name,
                        style: const TextStyle(
                            fontFamily: 'KhmerOS',
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    const SizedBox(height: 4),
                    Text("${item.weight}, \$${item.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontFamily: 'KhmerOS',
                            color: Colors.grey,
                            fontSize: 13)),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("\$${item.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontFamily: 'KhmerOS',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF53B175))),
                  const SizedBox(height: 15),
                  Text(item.date,
                      style: const TextStyle(
                          fontFamily: 'KhmerOS', color: Colors.grey, fontSize: 11)),
                ],
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ស្ថានភាព: ${item.status}",
                style: TextStyle(
                  fontFamily: 'KhmerOS',
                  color: item.status == "Delivered" ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              TextButton(
                onPressed: () => _showReorderBottomSheet(item, context),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF53B175).withOpacity(0.1),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("បញ្ជាទិញម្តងទៀត",
                    style: TextStyle(
                        fontFamily: 'KhmerOS',
                        color: Color(0xFF53B175),
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ReorderBottomSheet extends StatefulWidget {
  final OrderItem item;

  const ReorderBottomSheet({super.key, required this.item});

  @override
  State<ReorderBottomSheet> createState() => _ReorderBottomSheetState();
}

class _ReorderBottomSheetState extends State<ReorderBottomSheet> {
  int _quantity = 1;

  @override
  @override
  Widget build(BuildContext context) {
    final double totalPrice = widget.item.price * _quantity;

    return Container(
      // Use padding to account for the bottom safe area (home indicator)
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      // Use MainAxisSize.min so the sheet only takes up the space it needs
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "បញ្ជាទិញម្តងទៀត",
                  style: TextStyle(
                    fontFamily: 'KhmerOS',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          // Flexible content area
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Product Summary Row (Instead of a huge card, use a row to save space)
                  Row(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(widget.item.imagePath, fit: BoxFit.contain),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.item.name,
                                style: const TextStyle(
                                    fontFamily: 'KhmerOS',
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(widget.item.weight,
                                style: TextStyle(
                                    fontFamily: 'KhmerOS',
                                    color: Colors.grey.shade600, fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Quantity & Price Selector
                  _buildSectionContainer(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("បរិមាណ",
                                style: TextStyle(fontFamily: 'KhmerOS', fontWeight: FontWeight.w600)),
                            Row(
                              children: [
                                _buildQuantityButton(Icons.remove, () {
                                  if (_quantity > 1) setState(() => _quantity--);
                                }),
                                const SizedBox(width: 15),
                                Text("$_quantity", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(width: 15),
                                _buildQuantityButton(Icons.add, () {
                                  setState(() => _quantity++);
                                }),
                              ],
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(),
                        ),
                        _buildPriceRow("ចំនួនសរុប", "\$${totalPrice.toStringAsFixed(2)}", isTotal: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Bottom Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // ... your logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryAppColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text("បញ្ចូលក្នុងកាត់",
                    style: TextStyle(fontFamily: 'KhmerOS', color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

// Helper to keep code clean
  Widget _buildSectionContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: child,
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, color: AppColors.primaryAppColor, size: 20),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value,
      {bool isTotal = false, Key? key}) {
    return Row(
      key: key,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontFamily: 'KhmerOS',
                fontSize: 14, color: isTotal ? Colors.black : Colors.grey)),
        Text(value,
            style: TextStyle(
              fontFamily: 'KhmerOS',
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? AppColors.primaryAppColor : Colors.black,
            )),
      ],
    );
  }
}