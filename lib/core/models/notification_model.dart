class NotificationModel {
  final String category;
  final String title;
  final String subtitle;
  final String time; // <--- Check if this exists and is named exactly 'time'
  final String imagePath;
  bool isRead;

  NotificationModel({
    required this.category,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.imagePath,
    this.isRead = false,
  });
}