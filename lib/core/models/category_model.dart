// lib/core/models/category_model.dart
import 'package:flutter/material.dart';

class CategoryItem {
  final String id;
  final String title;
  final String imagePath;
  final Color backgroundColor;
  final Color borderColor;

  CategoryItem({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.backgroundColor,
    required this.borderColor,
  });
}