class OrderItem {
  final String productId; // Required for identifying the item
  final String name;
  final String weight;
  final double price;    // Changed to double for calculation
  final String date;
  final String imagePath;
  final int rating;
  final String status;   // Added status field

  OrderItem({
    required this.productId,
    required this.name,
    required this.weight,
    required this.price,
    required this.date,
    required this.imagePath,
    required this.rating,
    this.status = "Delivered", // Default status
  });
}