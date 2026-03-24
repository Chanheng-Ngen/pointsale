import 'package:flutter/material.dart';

class LowStockAlert extends StatelessWidget {
  final int lowStockCount;
  final VoidCallback onRestockAll;

  const LowStockAlert({
    super.key,
    required this.lowStockCount,
    required this.onRestockAll,
  });

  @override
  Widget build(BuildContext context) {
    if (lowStockCount == 0) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 0,
      color: const Color(0xFFFEE2E2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: const Color(0xFFFCA5A5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Low Stock Alert',
                    style: TextStyle(
                      fontFamily: 'Arimo',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF991B1B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$lowStockCount items need restocking',
                    style: const TextStyle(
                      fontFamily: 'Arimo',
                      fontSize: 14,
                      color: Color(0xFFB91C1C),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onRestockAll,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Restock All',
                style: TextStyle(
                  fontFamily: 'Arimo',
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
