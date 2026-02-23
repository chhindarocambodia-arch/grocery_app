import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/constants/app_colors.dart';
import 'package:grocery_app/core/data/shop_product_data.dart';
import 'package:grocery_app/core/models/product_model.dart';
import 'package:grocery_app/ui/screens/homescreen/cart_page.dart';
import 'package:grocery_app/ui/screens/homescreen/explore_page.dart';
import 'package:grocery_app/ui/screens/homescreen/account_page.dart';
import 'package:grocery_app/ui/screens/homescreen/fovorite_page.dart';
import 'package:grocery_app/ui/screens/homescreen/product_detail_screen.dart';
import 'package:grocery_app/ui/widgets/category_tile.dart';
import 'package:grocery_app/ui/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ShopPage(),
    ExplorePage(),
    const CartPage(),
    const FavoritePage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.fromLTRB(16, 0, 16, bottomPadding > 0 ? bottomPadding : 16),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.store, "ហាង", 0),           // Shop → ហាង
            _navItem(Icons.search, "ស្វែងរក", 1),       // Explore → ស្វែងរក
            _navItem(Icons.shopping_cart, "រទេះ", 2),    // Cart → រទេះ
            _navItem(Icons.favorite, "ចូលចិត្ត", 3),    // Favorite → ចូលចិត្ត
            _navItem(Icons.person, "គណនី", 4),         // Account → គណនី
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
            colors: [AppColors.primaryAppColor, Color(0xFF4A90E2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? Colors.white : Colors.grey.shade600,
            ),
            if (isSelected) ...[
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ===================================================
// SHOP PAGE
// ===================================================
class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final PageController _pageController = PageController();
  int _currentBannerIndex = 0;
  Timer? _bannerTimer;

  final List<String> _bannerImages = [
    'assets/images/Banner.jpg',
    'assets/images/Banner.jpg',
    'assets/images/Banner.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_currentBannerIndex < _bannerImages.length - 1) {
        _currentBannerIndex++;
      } else {
        _currentBannerIndex = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentBannerIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildSearchBar(),
          const SizedBox(height: 20),
          _buildPromoBanner(),
          _sectionHeader("ផ្តល់ជូនពិសេស"), // Exclusive Offer → ផ្តល់ជូនពិសេស
          _buildProductList(exclusiveOffers),
          _sectionHeader("លក់ដាច់បំផុត"), // Best Selling → លក់ដាច់បំផុត
          _buildProductList(bestSelling),
          _sectionHeader("មុខទំនិញ"), // Groceries → មុខទំនិញ
          _groceriesCategories(),
          const SizedBox(height: 20),
          _buildProductList(meatItems),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF2F3F2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'ស្វែងរកផលិតផល', // Search Store → ស្វែងរកផលិតផល
            hintStyle: TextStyle(color: Color(0xFF7C7C7C), fontWeight: FontWeight.w600),
            prefixIcon: Icon(Icons.search, color: Colors.black, size: 25),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentBannerIndex = index;
              });
            },
            itemCount: _bannerImages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    _bannerImages[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _bannerImages.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _currentBannerIndex == index ? 18 : 6,
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: _currentBannerIndex == index ? AppColors.primaryAppColor : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 25, 16, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTextColor)),
          const Text("មើលទាំងអស់", // See all → មើលទាំងអស់
              style: TextStyle(
                  color: AppColors.primaryAppColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildProductList(List<Product> products) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, _) => const SizedBox(width: 15),
        itemBuilder: (_, index) {
          final p = products[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(
                  name: p.name,
                  weight: p.weight,
                  price: p.price,
                  imageUrl: p.imageUrl,
                ),
              ),
            ),
            child: ProductCard(product: p),
          );
        },
      ),
    );
  }

  Widget _groceriesCategories() {
    final categories = [
      {
        "title": "ដំណាំបន្លែ", // Pulses → ដំណាំបន្លែ
        "color": const Color(0xFFF8A44C).withOpacity(0.15),
        "imageUrl": "assets/images/categories/pngfuel 1.png"
      },
      {
        "title": "អង្ករ", // Rice → អង្ករ
        "color": const Color(0xFF53B175).withOpacity(0.15),
        "imageUrl": "assets/images/categories/rice.png"
      },
    ];

    return SizedBox(
      height: 105,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, _) => const SizedBox(width: 15),
        itemCount: categories.length,
        itemBuilder: (_, index) {
          return CategoryTile(
            title: categories[index]['title'] as String,
            color: categories[index]['color'] as Color,
            imageUrl: categories[index]['imageUrl'] as String,
          );
        },
      ),
    );
  }
}
