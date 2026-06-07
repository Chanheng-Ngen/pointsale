import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:point_sale/core/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:point_sale/features/transactions/providers/transaction_provider.dart';
import 'package:point_sale/features/transactions/presentation/widgets/transaction_card.dart';
import 'package:point_sale/core/widgets/app_drawer.dart';


class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.1),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFE5E7EB), height: 1),
        ),
        leading: Builder(
          builder: (context) => Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.menu, color: Color(0xFF4A5565), size: 24),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        title: const Text(
          'Transactions',
          style: TextStyle(
            fontFamily: 'Arimo',
            fontSize: 20,
            color: Color(0xFF4A5565),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.file_download_outlined,
              color: Color(0xFF4A5565),
              size: 24,
            ),
            onPressed: () {
              // TODO: Implement export functionality
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search transactions...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
              onChanged: provider.setSearchQuery,
            ),
            SizedBox(height: 18),
            Row(
              spacing: 12,
              children: [
                _buildSummaryCard(
                  context,
                  'Sales',
                  '\$${provider.totalSales.toStringAsFixed(2)}',
                  const Color.fromRGBO(0, 212, 146, 1),
                ),
                _buildSummaryCard(
                  context,
                  'Refunds',
                  '\$${provider.totalRefunds.abs().toStringAsFixed(2)}',
                  const Color.fromRGBO(245, 73, 0, 1),
                ),
                _buildSummaryCard(
                  context,
                  'Expenses',
                  '\$${provider.totalExpenses.abs().toStringAsFixed(2)}',
                  const Color.fromRGBO(251, 44, 54, 1),
                ),
              ],
            ),
            SizedBox(height: 18),
            Row(
              children: [
                _buildFilterChip(context, 'All', provider),
                _buildFilterChip(context, 'Sale', provider),
                _buildFilterChip(context, 'Refund', provider),
                _buildFilterChip(context, 'Expense', provider),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: provider.transactions.length,
                itemBuilder: (context, index) {
                  return TransactionCard(
                    transaction: provider.transactions[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String amount,
    Color color,
  ) {
    return Expanded(
      child: Card(
        color: color,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                amount,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    TransactionProvider provider,
  ) {
    final isSelected = provider.selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: SizedBox(
        height: 50,
        child: ChoiceChip(
          showCheckmark: false,
          label: Center(child: Text(label)),
          selected: isSelected,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          onSelected: (selected) {
            if (selected) {
              provider.setSelectedFilter(label);
            }
          },
          selectedColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: AppColors.borderDark),
          ),
        ),
      ),
    );
  }
}
