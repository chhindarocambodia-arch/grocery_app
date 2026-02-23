import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_colors.dart';
import 'package:grocery_app/core/models/product_model.dart';
import 'package:grocery_app/ui/screens/homescreen/filter_screen.dart';
import 'package:grocery_app/ui/screens/homescreen/product_detail_screen.dart';

import 'package:grocery_app/ui/widgets/product_card.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({super.key});

  final Map<String, CategoryData> categories = {
    "fruits": CategoryData(
      id: "fruits",
      title: "ផ្លែឈើ\nនិងបន្លែ",
      imagePath: "assets/images/explore/fruit_basket.png",
      backgroundColor: const Color(0xFFEEF7F1),
      borderColor: const Color(0xFF53B175).withOpacity(0.7),
      products: [
        const Product(
          name: "ចេកសរីរាង្គ",
          weight: "7pcs",
          price: 4.99,
          imageUrl: "assets/images/explore/banana.png",
        ),
        const Product(
          name: "ផ្លែប៉ោមក្រហម",
          weight: "1kg",
          price: 5.99,
          imageUrl: "assets/images/explore/red_apple.png",
        ),
        const Product(
          name: "ម្ទេសប្លោកក្រហម",
          weight: "1kg",
          price: 2.99,
          imageUrl: "assets/images/explore/bell_pepper1.png",
        ),

      ],
    ),
    "oil": CategoryData(
      id: "oil",
      title: "ប្រេងចម្អិន\nនិងប្រេងឃី",
      imagePath: "assets/images/explore/oil.png",
      backgroundColor: const Color(0xFFF8F5E9),
      borderColor: const Color(0xFFF8A44C).withOpacity(0.7),
      products: [
        const Product(
          name: "ប្រេងផ្កាឈូក Fortune",
          weight: "2L",
          price: 12.99,
          imageUrl: "assets/images/explore/sunflower_oil.jpg",
        ),
        const Product(
          name: "ប្រេងអូលីវ Extra Virgin",
          weight: "1L",
          price: 18.50,
          imageUrl: "assets/images/explore/olive_oil.jpg",
        ),
        const Product(
          name: "ប្រេងឃីគោសុទ្ធ",
          weight: "500g",
          price: 15.99,
          imageUrl: "assets/images/explore/ghee.jpg",
        ),
        const Product(
          name: "ប្រេងកាណូឡា",
          weight: "1L",
          price: 8.99,
          imageUrl: "assets/images/explore/canola_oil.jpg",
        ),
        const Product(
          name: "ប្រេងមូស្តាត",
          weight: "500ml",
          price: 4.49,
          imageUrl: "assets/images/explore/mustard_oil.jpg",
        ),
        const Product(
          name: "ប្រេងដូង",
          weight: "250ml",
          price: 6.99,
          imageUrl: "assets/images/explore/coconut_oil.jpg",
        ),
      ],
    ),
    "meat": CategoryData(
      id: "meat",
      title: "សាច់\nនិងត្រី",
      imagePath: "assets/images/explore/meat.png",
      backgroundColor: const Color(0xFFFDE8E4),
      borderColor: const Color(0xFFF7A593).withOpacity(0.7),
      products: [
        const Product(
          name: "សាច់គោស្រស់",
          weight: "1kg",
          price: 12.99,
          imageUrl: "assets/images/explore/beef.png",
        ),
        const Product(
          name: "មាន់ទាំងមូល",
          weight: "1.5kg",
          price: 9.50,
          imageUrl: "assets/images/explore/chicken.png",
        ),
        const Product(
          name: "សាឡម៉ុង",
          weight: "250g",
          price: 15.99,
          imageUrl: "assets/images/explore/salmon.png",
        ),
        const Product(
          name: "ចៀមខ្លាឃ្មុំ",
          weight: "500g",
          price: 18.50,
          imageUrl: "assets/images/explore/prawns.jpg",
        ),
      ],
    ),
    "bakery": CategoryData(
      id: "bakery",
      title: "នំ\nនិងស្នាក់",
      imagePath: "assets/images/explore/bakery.png",
      backgroundColor: const Color(0xFFF4EBF7),
      borderColor: const Color(0xFFD3B0E0).withOpacity(0.7),
      products: [
        const Product(
          name: "នំបុ័ងស",
          weight: "400g",
          price: 2.50,
          imageUrl: "assets/images/explore/white_bread.png",
        ),
        const Product(
          name: "គូក៊ីសូកូឡា",
          weight: "200g",
          price: 3.99,
          imageUrl: "assets/images/explore/cookies.jpg",
        ),
        const Product(
          name: "បន្ទះសាច់ដំឡូងបារាំង",
          weight: "150g",
          price: 1.99,
          imageUrl: "assets/images/explore/chips.jpg",
        ),
        const Product(
          name: "ក្រូសង់ប៊ឺរ",
          weight: "2pcs",
          price: 2.99,
          imageUrl: "assets/images/explore/croissant.jpg",
        ),
        const Product(
          name: "អណ្តូងចំរះ",
          weight: "250g",
          price: 5.49,
          imageUrl: "assets/images/explore/nuts.jpg",
        ),
        const Product(
          name: "ក្រាកឃើរចិចស៊ី",
          weight: "100g",
          price: 1.50,
          imageUrl: "assets/images/explore/crackers.jpg",
        ),
      ],
    ),
    "dairy": CategoryData(
      id: "dairy",
      title: "ដីរី\nនិងពងមាន់",
      imagePath: "assets/images/explore/dairy.png",
      backgroundColor: const Color(0xFFFFF9E5),
      borderColor: const Color(0xFFFDE598).withOpacity(0.7),
      products: [
        const Product(
          name: "ស៊ុតមាន់ក្រហម",
          weight: "4pcs",
          price: 1.99,
          imageUrl: "assets/images/explore/egg_red.jpg",
        ),
        const Product(
          name: "Egg Chicken White",
          weight: "18pcs",
          price: 15.50,
          imageUrl: "assets/images/explore/egg_white.png",
        ),
        const Product(
          name: "Egg Pasta",
          weight: "30gm",
          price: 15.99,
          imageUrl: "assets/images/explore/egg_pasta.jpg",
        ),
        const Product(
          name: "Egg Noodles",
          weight: "2L",
          price: 15.99,
          imageUrl: "assets/images/explore/egg_noodles.jpg",
        ),
      ],
    ),
    "beverages": CategoryData(
      id: "beverages",
      title: "ភេសជ្ជៈ",
      imagePath: "assets/images/explore/beverages.png",
      backgroundColor: const Color(0xFFEDF7FC),
      borderColor: const Color(0xFFB7DFF5).withOpacity(0.7),
      products: [
        const Product(
          name: "Diet Coke",
          weight: "355ml",
          price: 1.99,
          imageUrl: "assets/images/beverage/diet_coke.png",
        ),
        const Product(
          name: "Sprite Can",
          weight: "325ml",
          price: 1.50,
          imageUrl: "assets/images/beverage/sprite.png",
        ),
        const Product(
          name: "Apple & Grape Juice",
          weight: "2L",
          price: 15.99,
          imageUrl: "assets/images/beverage/tree-top-juice-apple.png",
        ),
        const Product(
          name: "Orange Juice",
          weight: "2L",
          price: 15.99,
          imageUrl: "assets/images/beverage/orange_juice.png",
        ),
        const Product(
          name: "Coca Cola Can",
          weight: "325ml",
          price: 4.99,
          imageUrl: "assets/images/beverage/coke.png",
        ),
        const Product(
          name: "Pepsi Can",
          weight: "330ml",
          price: 4.99,
          imageUrl: "assets/images/beverage/pepsi.png",
        ),
      ],
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "ស្វែងរកផលិតផល",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'KhmerOS',
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF2F3F2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const TextField(
                style: TextStyle(fontFamily: 'KhmerOS'),
                decoration: InputDecoration(
                  hintText: "ស្វែងរកហាង",
                  prefixIcon: Icon(Icons.search, color: Colors.black, size: 25),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),

          // Categories Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (context, index) {
                final category = categories.values.elementAt(index);
                return CategoryCard(
                  category: category,
                  onTap: () => _navigateToCategory(context, category),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCategory(BuildContext context, CategoryData category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(category: category),
      ),
    );
  }
}

class CategoryData {
  final String id;
  final String title;
  final String imagePath;
  final Color backgroundColor;
  final Color borderColor;
  final List<Product> products;

  CategoryData({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.backgroundColor,
    required this.borderColor,
    required this.products,
  });
}

class CategoryCard extends StatelessWidget {
  final CategoryData category;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: category.backgroundColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: category.borderColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(category.imagePath, fit: BoxFit.contain),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 5, right: 5),
              child: Text(
                category.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                  height: 1.2,
                  fontFamily: 'KhmerOS',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final CategoryData category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          category.title.replaceAll('\n', ' '),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'KhmerOS',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.black),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                builder: (context) => const FilterScreen(),
              );
            },
          )
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: category.products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (context, index) {
          final product = category.products[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(
                  name: product.name,
                  weight: product.weight,
                  price: product.price,
                  imageUrl: product.imageUrl,
                ),
              ),
            ),
            child: ProductCard(product: product),
          );
        },
      ),
    );
  }
}
