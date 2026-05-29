import 'package:flutter/material.dart';
import 'package:point_sale/features/products/data/models/product_inventory.dart';

class ProductInventoryProvider extends ChangeNotifier {
  final List<ProductInventory> _products = [
    ProductInventory(
      id: '1',
      name: 'Wireless Mouse',
      sku: 'WM-001',
      category: 'Electronics',
      price: 29.99,
      stock: 45,
      status: 'in stock',
    ),
    ProductInventory(
      id: '2',
      name: 'USB Cable',
      sku: 'UC-002',
      category: 'Accessories',
      price: 9.99,
      stock: 8,
      status: 'low stock',
    ),
    ProductInventory(
      id: '3',
      name: 'Keyboard',
      sku: 'KB-003',
      category: 'Electronics',
      price: 79.99,
      stock: 23,
      status: 'in stock',
    ),
    ProductInventory(
      id: '4',
      name: 'Monitor',
      sku: 'MN-004',
      category: 'Electronics',
      price: 299.99,
      stock: 0,
      status: 'out of-stock',
    ),
    ProductInventory(
      id: '5',
      name: 'Headphones',
      sku: 'HP-005',
      category: 'Audio',
      price: 149.99,
      stock: 15,
      status: 'in stock',
    ),
    ProductInventory(
      id: '6',
      name: 'Webcam',
      sku: 'WC-006',
      category: 'Electronics',
      price: 89.99,
      stock: 12,
      status: 'in stock',
    ),
    ProductInventory(
      id: '7',
      name: 'Phone Case',
      sku: 'PC-007',
      category: 'Accessories',
      price: 19.99,
      stock: 32,
      status: 'in stock',
    ),
    ProductInventory(
      id: '8',
      name: 'Laptop Stand',
      sku: 'LS-008',
      category: 'Furniture',
      price: 49.99,
      stock: 18,
      status: 'in stock',
    ),
  ];

  String _searchQuery = '';

  void addProduct(ProductInventory newProduct) {
    _products.insert(0, newProduct);
    notifyListeners();
  }

  void updateProduct(ProductInventory updatedProduct) {
    final index = _products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }


  List<ProductInventory> get products {
    if (_searchQuery.isEmpty) return _products;
    return _products.where((p) {
      return p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.sku.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  int get totalProducts => _products.length;

  int get lowStockCount => _products.where((p) => p.status == 'low stock').length;

  int get outOfStockCount => _products.where((p) => p.status == 'out of-stock').length;

  List<Map<String, dynamic>> get categoriesWithCounts {
    final Map<String, int> counts = {};
    for (var p in _products) {
      counts[p.category] = (counts[p.category] ?? 0) + 1;
    }
    
    final List<Map<String, dynamic>> result = [];
    counts.forEach((key, value) {
      result.add({'name': key, 'count': value});
    });
    
    // Sort categories alphabetically
    result.sort((a, b) => a['name'].compareTo(b['name']));
    return result;
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
