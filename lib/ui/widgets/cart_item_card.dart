import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';

class CartItemCard extends StatelessWidget {
  final Product product;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.product,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final itemTotal = product.price * product.quantity;

    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1.15,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
            spreadRadius: -1,
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Row: Image, Name, Price, Delete
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    product.emoji,
                    style: const TextStyle(
                      fontSize: 30,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 18,
                        color: Color(0xFF0A0A0A),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 16,
                        color: Color(0xFF4A5565),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              // Delete Button
              InkWell(
                onTap: onRemove,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 36,
                  height: 36,
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Color(0xFFEF4444),
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Bottom Row: Quantity Control & Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Quantity Control
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    // Decrement Button
                    InkWell(
                      onTap: onDecrement,
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.remove,
                          size: 16,
                          color: Color(0xFF0A0A0A),
                        ),
                      ),
                    ),
                    // Quantity
                    SizedBox(
                      width: 32,
                      child: Center(
                        child: Text(
                          '${product.quantity}',
                          style: const TextStyle(
                            fontFamily: 'Arimo',
                            fontSize: 16,
                            color: Color(0xFF0A0A0A),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    // Increment Button
                    InkWell(
                      onTap: onIncrement,
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 16,
                          color: Color(0xFF0A0A0A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Item Total
              Text(
                '\$${itemTotal.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontFamily: 'Arimo',
                  fontSize: 18,
                  color: Color(0xFF0A0A0A),
                  height: 1.56,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
