import 'package:flutter/material.dart';

class PolicyDetailScreen extends StatelessWidget {
  final String title;
  final String content;
  final String lastUpdated;

  const PolicyDetailScreen({
    super.key,
    required this.title,
    required this.content,
    this.lastUpdated = "January 2026",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'KhmerOS',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ចុងក្រោយបានកែសម្រួល៖ $lastUpdated",
              style: TextStyle(
                fontFamily: 'KhmerOS',
                color: Colors.grey[600],
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              content,
              style: const TextStyle(
                fontFamily: 'KhmerOS',
                fontSize: 15,
                color: Colors.black87,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
