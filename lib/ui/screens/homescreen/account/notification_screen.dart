import 'package:flutter/material.dart';
import 'package:grocery_app/core/models/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Colors
  static const unreadBg = Color(0xFFF2F3F2);
  static const borderColor = Color(0xFFE2E2E2);
  static const primaryGreen = Color(0xFF53B175);

  // Mock data
  final List<NotificationModel> notifications = [
    NotificationModel(
      category: "ការបញ្ចុះតម្លៃ", // Khmer
      title: "ទទួលបានការបញ្ចុះតម្លៃ 20%",
      subtitle: "🎉 ទិញឥឡូវនេះ និងទទួលបានការបញ្ចុះតម្លៃ 20% ថ្ងៃនេះ។",
      time: "02.01.26 9:04 PM",
      imagePath: 'assets/images/account/orders/bell_pepper1.png',
    ),
    NotificationModel(
      category: "លក់ដូរ", // Khmer
      title: "ការដឹកជញ្ជូនដោយឥតគិតថ្លៃ",
      subtitle: "ការដឹកជញ្ជូនឥតគិតថ្លៃសម្រាប់ការកម្មង់លើ \$30 នាភ្លោះចុងសប្តាហ៍នេះ!",
      time: "01.01.26 10:00 AM",
      imagePath: 'assets/images/account/orders/bell_pepper1.png',
    ),
  ];

  List<NotificationModel> get sortedNotifications {
    final list = [...notifications];
    list.sort((a, b) {
      if (a.isRead == b.isRead) {
        return b.time.compareTo(a.time);
      }
      return a.isRead ? 1 : -1;
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "ការជូនដំណឹង និង ផ្តល់ជូន",
          style: TextStyle(
              fontFamily: 'KhmerOS', color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: sortedNotifications.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: sortedNotifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) =>
            _buildNotificationCard(sortedNotifications[index]),
      ),
    );
  }

  Widget _buildNotificationCard(NotificationModel item) {
    return InkWell(
      onTap: () => _showGreatNewsDialog(context, item),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: item.isRead ? Colors.white : unreadBg,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(item.imagePath, fit: BoxFit.contain),
            ),
            const SizedBox(width: 15),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category + NEW badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.category,
                        style: const TextStyle(
                          fontFamily: 'KhmerOS',
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      if (!item.isRead)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryGreen,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "ថ្មី", // Khmer for NEW
                            style: TextStyle(
                              fontFamily: 'KhmerOS',
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Title
                  Text(
                    item.title,
                    style: const TextStyle(
                        fontFamily: 'KhmerOS', fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),

                  // Subtitle
                  Text(
                    item.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: 'KhmerOS', color: Colors.black54, fontSize: 13),
                  ),
                  const SizedBox(height: 6),

                  // Time
                  Text(
                    item.time,
                    style: const TextStyle(fontFamily: 'KhmerOS', color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 15),
          const Text(
            "មិនមានការជូនដំណឹង",
            style: TextStyle(fontFamily: 'KhmerOS', color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void _showGreatNewsDialog(BuildContext context, NotificationModel item) {
    setState(() => item.isRead = true);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.campaign, color: primaryGreen),
            SizedBox(width: 8),
            Text(
              "ព័ត៌មានល្អ",
              style: TextStyle(fontFamily: 'KhmerOS', fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          item.subtitle,
          style: const TextStyle(fontFamily: 'KhmerOS'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "យល់ព្រម",
              style: TextStyle(
                  fontFamily: 'KhmerOS', color: primaryGreen, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
