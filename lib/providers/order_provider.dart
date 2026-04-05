import 'package:flutter/material.dart';
import 'package:point_sale/models/order.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _orders = [
    OrderModel(
      id: 'ORD-1001',
      customerName: 'John Doe',
      status: 'completed',
      itemCount: 3,
      time: '10:30 AM',
      subtotal: 109.06,
      tax: 10.91,
      total: 119.97,
    ),
    OrderModel(
      id: 'ORD-1002',
      customerName: 'Jane Smith',
      status: 'pending',
      itemCount: 5,
      time: '11:15 AM',
      subtotal: 227.23,
      tax: 22.72,
      total: 249.95,
    ),
    OrderModel(
      id: 'ORD-1003',
      customerName: 'Bob Wilson',
      status: 'completed',
      itemCount: 2,
      time: '12:00 PM',
      subtotal: 81.80,
      tax: 8.18,
      total: 89.98,
    ),
    OrderModel(
      id: 'ORD-1004',
      customerName: 'Alice Brown',
      status: 'pending',
      itemCount: 1,
      time: '01:45 PM',
      subtotal: 272.72,
      tax: 27.27,
      total: 299.99,
    ),
    OrderModel(
      id: 'ORD-1005',
      customerName: 'Charlie Davis',
      status: 'cancelled',
      itemCount: 4,
      time: '02:30 PM',
      subtotal: 163.60,
      tax: 16.36,
      total: 179.96,
    ),
  ];

  String _searchQuery = '';
  String _selectedFilter = 'All';

  String get selectedFilter => _selectedFilter;

  List<OrderModel> get orders {
    List<OrderModel> filteredOrders = _orders;

    if (_selectedFilter != 'All') {
      filteredOrders = filteredOrders
          .where((o) => o.status == _selectedFilter.toLowerCase())
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      filteredOrders = filteredOrders
          .where(
            (o) =>
                o.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                o.customerName.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    return filteredOrders;
  }

  int get totalOrdersCount => _orders.length;

  int get pendingOrdersCount =>
      _orders.where((o) => o.status == 'pending').length;

  int get completedOrdersCount =>
      _orders.where((o) => o.status == 'completed').length;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void updateOrderStatus(String orderId, String newStatus) {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      final order = _orders[index];
      _orders[index] = OrderModel(
        id: order.id,
        customerName: order.customerName,
        status: newStatus,
        itemCount: order.itemCount,
        time: order.time,
        subtotal: order.subtotal,
        tax: order.tax,
        total: order.total,
      );
      notifyListeners();
    }
  }
}
