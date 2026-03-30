import 'package:flutter/material.dart';

class ProductInventory {
  final String id;
  final String name;
  final String sku;
  final String category;
  final double price;
  final int stock;
  final String status; // 'in stock', 'low stock', 'out of-stock'

  ProductInventory({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.price,
    required this.stock,
    required this.status,
  });
}
