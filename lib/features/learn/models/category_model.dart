import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;

  const CategoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
  });
}
