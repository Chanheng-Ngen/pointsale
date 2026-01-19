import 'package:flutter/material.dart';
import 'package:point_sale/models/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  final List<Transaction> _transactions = [
    Transaction(
      id: 'TXN-1001',
      type: 'sale',
      description: 'Order #ORD-1001',
      paymentMethod: 'Card',
      time: '10:30 AM',
      amount: 119.97,
    ),
    Transaction(
      id: 'TXN-1002',
      type: 'sale',
      description: 'Order #ORD-1002',
      paymentMethod: 'Cash',
      time: '11:15 AM',
      amount: 249.95,
    ),
    Transaction(
      id: 'TXN-1003',
      type: 'refund',
      description: 'Return - Order #ORD-998',
      paymentMethod: 'Card',
      time: '12:00 PM',
      amount: -45.00,
    ),
    Transaction(
      id: 'TXN-1004',
      type: 'sale',
      description: 'Order #ORD-1003',
      paymentMethod: 'Digital',
      time: '12:30 PM',
      amount: 89.98,
    ),
    Transaction(
      id: 'TXN-1005',
      type: 'expense',
      description: 'Office Supplies',
      paymentMethod: 'Card',
      time: '01:00 PM',
      amount: -125.50,
    ),
    Transaction(
      id: 'TXN-1006',
      type: 'sale',
      description: 'Order #ORD-1004',
      paymentMethod: 'Card',
      time: '01:45 PM',
      amount: 299.99,
    ),
  ];

  String _searchQuery = '';
  String _selectedFilter = 'All';

  String get selectedFilter => _selectedFilter;

  List<Transaction> get transactions {
    List<Transaction> filteredTransactions = _transactions;

    if (_selectedFilter != 'All') {
      filteredTransactions = filteredTransactions
          .where((t) => t.type == _selectedFilter.toLowerCase())
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      filteredTransactions = filteredTransactions
          .where(
            (t) =>
                t.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                t.description.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    return filteredTransactions;
  }

  double get totalSales => _transactions
      .where((t) => t.type == 'sale')
      .fold(0.0, (sum, item) => sum + item.amount);

  double get totalRefunds => _transactions
      .where((t) => t.type == 'refund')
      .fold(0.0, (sum, item) => sum + item.amount.abs());

  double get totalExpenses => _transactions
      .where((t) => t.type == 'expense')
      .fold(0.0, (sum, item) => sum + item.amount.abs());

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }
}
