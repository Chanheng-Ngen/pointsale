import 'package:flutter/material.dart';
import 'package:point_sale/features/stock/data/models/stock_item.dart';

class StockProvider extends ChangeNotifier {
  final List<StockItem> _items = [
    StockItem(
      id: '1',
      name: 'Wireless Mouse',
      sku: 'WM-001',
      category: 'Electronics',
      current: 45,
      min: 20,
      max: 100,
      lastRestocked: '2 days ago',
      status: 'normal',
    ),
    StockItem(
      id: '2',
      name: 'USB Cable',
      sku: 'UC-002',
      category: 'Accessories',
      current: 8,
      min: 15,
      max: 50,
      lastRestocked: '1 week ago',
      status: 'low',
    ),
    StockItem(
      id: '3',
      name: 'Keyboard',
      sku: 'KB-003',
      category: 'Electronics',
      current: 23,
      min: 10,
      max: 50,
      lastRestocked: '3 days ago',
      status: 'normal',
    ),
    StockItem(
      id: '4',
      name: 'Monitor',
      sku: 'MN-004',
      category: 'Electronics',
      current: 5,
      min: 8,
      max: 25,
      lastRestocked: '2 weeks ago',
      status: 'low',
    ),
    StockItem(
      id: '5',
      name: 'Headphones',
      sku: 'HP-005',
      category: 'Audio',
      current: 15,
      min: 10,
      max: 40,
      lastRestocked: '5 days ago',
      status: 'normal',
    ),
    StockItem(
      id: '6',
      name: 'Mouse Pad',
      sku: 'HP-006',
      category: 'Accessories',
      current: 3,
      min: 10,
      max: 50,
      lastRestocked: '3 weeks ago',
      status: 'low',
    ),
    StockItem(
      id: '7',
      name: 'Webcam',
      sku: 'WC-007',
      category: 'Electronics',
      current: 12,
      min: 8,
      max: 30,
      lastRestocked: '4 days ago',
      status: 'normal',
    ),
    StockItem(
      id: '8',
      name: 'Phone Case',
      sku: 'PC-008',
      category: 'Accessories',
      current: 42,
      min: 15,
      max: 60,
      lastRestocked: '1 day ago',
      status: 'normal',
    ),
  ];

  String selectedCategory = 'All';
  String selectedStatus = 'All Items';
  String searchQuery = '';

  List<StockItem> get items {
    return _items.where((item) {
      final matchSearch = item.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item.sku.toLowerCase().contains(searchQuery.toLowerCase());

      final matchCategory =
          selectedCategory == 'All' || item.category == selectedCategory;

      final matchStatus = selectedStatus == 'All Items' ||
          (selectedStatus == 'Low Stock' && item.status == 'low') ||
          (selectedStatus == 'Normal' && item.status == 'normal') ||
          (selectedStatus == 'Well Stocked' && item.status == 'well');

      return matchSearch && matchCategory && matchStatus;
    }).toList();
  }

  List<StockItem> get lowStockItems {
    return _items.where((item) => item.status == 'low').toList();
  }

  double get totalValue {
    // This is a dummy calculation. You should replace it with your actual logic.
    return _items.fold(0.0, (sum, item) => sum + (item.current * 12.5));
  }

  int get lowStockCount => _items.where((e) => e.status == 'low').length;

  void setSearch(String value) {
    searchQuery = value;
    notifyListeners();
  }

  void setCategory(String value) {
    selectedCategory = value;
    notifyListeners();
  }

  void setStatus(String value) {
    selectedStatus = value;
    notifyListeners();
  }

  void restockItem(String id, int qty) {
    for (final item in _items) {
      if (item.id == id) {
        item.current = (item.current + qty).clamp(0, item.max);
        item.status = item.current < item.min
            ? 'low'
            : item.current >= item.max * 0.7
                ? 'well'
                : 'normal';
        item.lastRestocked = 'Just now';
      }
    }
    notifyListeners();
  }

  void restockAllLow() {
    for (final item in _items) {
      if (item.status == 'low') {
        item.current = item.max;
        item.status = 'well';
        item.lastRestocked = 'Just now';
      }
    }
    notifyListeners();
  }
}
