import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_colors.dart';
import 'package:grocery_app/core/models/product_model.dart';
import 'package:grocery_app/routes/app_routes.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  void _addAllToCart() {
    if (favoriteItems.isEmpty) return;
    setState(() {
      for (var product in favoriteItems) {
        int index = globalCartList.indexWhere((item) => item.product.name == product.name);
        if (index != -1) {
          globalCartList[index].quantity++;
        } else {
          globalCartList.add(CartItem(product: product, quantity: 1));
        }
      }
    });
    _showSnackBar("${favoriteItems.length} ផលិតផលបានបញ្ចូលទៅកាងសំបុក!");
  }

  void _removeItem(int index) {
    final removedItem = favoriteItems[index];
    setState(() => favoriteItems.removeAt(index));
    _showSnackBar("${removedItem.name} ត្រូវបានលុប", isUndo: true, onUndo: () {
      setState(() => favoriteItems.insert(index, removedItem));
    });
  }

  void _showSnackBar(String message, {bool isUndo = false, VoidCallback? onUndo}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontFamily: 'KhmerOS')),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primaryAppColor,
        action: isUndo
            ? SnackBarAction(
            label: "UNDO", textColor: Colors.white, onPressed: onUndo!)
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          "ផលិតផលចូលចិត្ត", // Khmer for "Favorites"
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 22, fontFamily: 'KhmerOS'),
        ),
      ),
      body: favoriteItems.isEmpty
          ? _buildEmptyState()
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) =>
                  _buildDismissibleTile(favoriteItems[index], index),
            ),
          ),
          _buildBottomAction(),
        ],
      ),
    );
  }

  Widget _buildDismissibleTile(Product item, int index) {
    return Dismissible(
      key: ValueKey(item.name + index.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      onDismissed: (_) => _removeItem(index),
      child: _buildFavoriteTile(item),
    );
  }

  Widget _buildFavoriteTile(Product item) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(item.imageUrl, width: 60, height: 60, fit: BoxFit.contain),
        ),
        title: Text(item.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'KhmerOS')),
        subtitle: Text(item.weight,
            style: const TextStyle(color: Colors.grey, fontFamily: 'KhmerOS')),
        trailing: Text("\$${item.price.toStringAsFixed(2)}",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryAppColor,
                fontSize: 16,
                fontFamily: 'KhmerOS')),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 90, color: Colors.grey.shade300),
          const SizedBox(height: 20),
          const Text("គ្មានផលិតផលចូលចិត្តទេ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'KhmerOS')),
          const SizedBox(height: 8),
          const Text("ចាប់ផ្តើមចុចបេះដូងលើផលិតផលដើម្បីមើលទីនេះ!",
              style: TextStyle(color: Colors.grey, fontFamily: 'KhmerOS')),
          const SizedBox(height: 32),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryAppColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 6,
              ),
              child: const Text("ទៅទិញម្ដងទៀត", // Khmer: "Go Shopping"
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'KhmerOS')),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade100)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: _addAllToCart,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 6,
              backgroundColor: Colors.transparent,
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
              child: const Center(
                child: Text(
                  "បញ្ចូលទាំងអស់ទៅកាត់", // Khmer: "Add All To Cart"
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
      ),
    );
  }
}
