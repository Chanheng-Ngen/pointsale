import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddPressed;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddPressed,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1.15,
        ),
      ),
      child: Column(
        children: [
          // Emoji Icon
          const SizedBox(height: 16),
          SizedBox(
            height: 40,
            child: Center(
              child: Text(
                product.emoji,
                style: const TextStyle(
                  fontSize: 36,
                  height: 1.11,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          // Product Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              product.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Arimo',
                fontSize: 14,
                color: Color(0xFF0A0A0A),
                height: 1.43,
              ),
            ),
          ),
          const SizedBox(height: 4),
          
          // Price
          Text(
            '\$${product.price.toStringAsFixed(product.price == product.price.roundToDouble() ? 0 : 2)}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Arimo',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00B8DB),
              height: 1.5,
            ),
          ),
          const Spacer(),
          
          // Add Button or Quantity Control
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              height: 36,
              child: product.isInCart
                  ? Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00B8DB).withOpacity(0.75),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Decrement Button
                          InkWell(
                            onTap: onDecrement,
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(
                                Icons.remove,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Quantity
                          Text(
                            '${product.quantity}',
                            style: const TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 16,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                          // Increment Button
                          InkWell(
                            onTap: onIncrement,
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ElevatedButton(
                      onPressed: onAddPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00B8DB),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                        padding: EdgeInsets.zero,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 16,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Add',
                            style: TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 14,
                              height: 1.43,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
