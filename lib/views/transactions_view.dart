import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:point_sale/providers/transaction_provider.dart';
import 'package:point_sale/widgets/transaction_card.dart';
import 'package:point_sale/widgets/app_drawer.dart';
import 'package:point_sale/core/theme/app_colors.dart';

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
            icon: const Icon(Icons.file_download_outlined, color: Color(0xFF4A5565), size: 24),
            onPressed: () {
              // TODO: Implement export functionality
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search transactions...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
              onChanged: provider.setSearchQuery,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryCard(
                  context,
                  'Sales',
                  '\$${provider.totalSales.toStringAsFixed(2)}',
                  Color.fromARGB(255, 43, 190, 141),
                ),
                _buildSummaryCard(
                  context,
                  'Refunds',
                  '\$${provider.totalRefunds.abs().toStringAsFixed(2)}',
                  const Color.fromARGB(255, 226, 83, 0),
                ),
                _buildSummaryCard(
                  context,
                  'Expenses',
                  '\$${provider.totalExpenses.abs().toStringAsFixed(2)}',
                  const Color.fromARGB(255, 255, 62, 48),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildFilterChip(context, 'All', provider),
                _buildFilterChip(context, 'Sale', provider),
                _buildFilterChip(context, 'Refund', provider),
                _buildFilterChip(context, 'Expense', provider),
              ],
            ),
          ),
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
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            provider.setSelectedFilter(label);
          }
        },
      ),
    );
  }
}
