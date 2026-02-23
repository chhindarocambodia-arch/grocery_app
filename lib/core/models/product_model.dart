class Product {
  final String name;
  final String weight;
  final double price;
  final String imageUrl;

  const Product({
    required this.name,
    required this.weight,
    required this.price,
    required this.imageUrl,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

// Shared global state between screens
List<CartItem> globalCartList = [
  CartItem(
    product: const Product(
      name: "Bell Pepper Red",
      weight: "1kg",
      price: 4.99,
      imageUrl: "assets/images/products/bell_pepper1.png",
    ),
  ),
];

final List<Product> favoriteItems = [
  const Product(
    name: "Sprite Can",
    weight: "325ml",
    price: 1.50,
    imageUrl: "assets/images/products/sprite.png",
  ),
  const Product(
    name: "Diet Coke",
    weight: "355ml",
    price: 1.99,
    imageUrl: "assets/images/products/diet_coke.png",
  ),
  const Product(
    name: "Apple Juice",
    weight: "2L",
    price: 15.50,
    imageUrl: "assets/images/products/juice.png",
  ),
];