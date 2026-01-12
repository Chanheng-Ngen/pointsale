import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/payment_method_modal.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cartItems;

  const CartScreen({
    super.key,
    required this.cartItems,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<Product> items;

  @override
  void initState() {
    super.initState();
    items = List.from(widget.cartItems);
  }

  double get subtotal {
    return items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get tax {
    return subtotal * 0.1; // 10% tax
  }

  double get total {
    return subtotal + tax;
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  void incrementQuantity(String productId) {
    setState(() {
      final index = items.indexWhere((p) => p.id == productId);
      if (index != -1) {
        items[index] = items[index].copyWith(
          quantity: items[index].quantity + 1,
        );
      }
    });
  }

  void decrementQuantity(String productId) {
    setState(() {
      final index = items.indexWhere((p) => p.id == productId);
      if (index != -1 && items[index].quantity > 1) {
        items[index] = items[index].copyWith(
          quantity: items[index].quantity - 1,
        );
      }
    });
  }

  void removeItem(String productId) {
    setState(() {
      items.removeWhere((p) => p.id == productId);
    });
  }

  void clearCart() {
    setState(() {
      items.clear();
    });
  }

  void showSuccessToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Color(0xFF00D492),
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontFamily: 'Arimo',
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF00D492).withOpacity(0.75),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4A5565)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Shopping Cart',
              style: TextStyle(
                fontFamily: 'Arimo',
                fontSize: 20,
                color: Color(0xFF0A0A0A),
                height: 1.4,
              ),
            ),
            Text(
              '$totalItems items',
              style: const TextStyle(
                fontFamily: 'Arimo',
                fontSize: 14,
                color: Color(0xFF4A5565),
                height: 1.43,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: const Color(0xFFE5E7EB),
            height: 1.15,
          ),
        ),
      ),
      body: Column(
        children: [
          // Cart Items
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF3F4F6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 40,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Your cart is empty',
                          style: TextStyle(
                            fontFamily: 'Arimo',
                            fontSize: 20,
                            color: Color(0xFF0A0A0A),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Add some products to get started',
                          style: TextStyle(
                            fontFamily: 'Arimo',
                            fontSize: 16,
                            color: Color(0xFF4A5565),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00B8DB),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Start Shopping',
                            style: TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return CartItemCard(
                        product: items[index],
                        onIncrement: () {
                          incrementQuantity(items[index].id);
                        },
                        onDecrement: () {
                          decrementQuantity(items[index].id);
                        },
                        onRemove: () {
                          removeItem(items[index].id);
                        },
                      );
                    },
                  ),
          ),

          // Order Summary & Actions
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Color(0xFFE5E7EB),
                  width: 1.15,
                ),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(16, 17, 16, 0),
            child: Column(
              children: [
                // Summary Box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      // Subtotal
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Subtotal',
                            style: TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 14,
                              color: Color(0xFF4A5565),
                              height: 1.43,
                            ),
                          ),
                          Text(
                            '\$${subtotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 14,
                              color: Color(0xFF0A0A0A),
                              height: 1.43,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Tax
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tax (10%)',
                            style: TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 14,
                              color: Color(0xFF4A5565),
                              height: 1.43,
                            ),
                          ),
                          Text(
                            '\$${tax.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 14,
                              color: Color(0xFF0A0A0A),
                              height: 1.43,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 9),
                      // Divider
                      const Divider(
                        color: Color(0xFFE5E7EB),
                        thickness: 1.15,
                        height: 1.15,
                      ),
                      const SizedBox(height: 9),
                      // Total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 18,
                              color: Color(0xFF0A0A0A),
                              height: 1.56,
                            ),
                          ),
                          Text(
                            '\$${total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 20,
                              color: Color(0xFF00B8DB),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Action Buttons
                Column(
                  children: [
                    // Pay Now Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: items.isEmpty
                            ? null
                            : () async {
                                final result = await showDialog<String>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return PaymentMethodModal(
                                      totalAmount: total,
                                    );
                                  },
                                );
                                
                                if (result != null && mounted) {
                                  // Payment confirmed - clear cart and show toast
                                  clearCart();
                                  showSuccessToast('Payment confirmed with $result');
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00B8DB),
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        icon: const Icon(Icons.credit_card, size: 20),
                        label: const Text(
                          'Pay Now',
                          style: TextStyle(
                            fontFamily: 'Arimo',
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Save for Later Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed: items.isEmpty
                            ? null
                            : () {
                                // Save for later - clear cart and show toast
                                clearCart();
                                showSuccessToast('Order saved! Pay later from Orders screen');
                              },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFFF3F4F6),
                          foregroundColor: const Color(0xFF101828),
                          side: const BorderSide(
                            color: Color(0xFFD1D5DC),
                            width: 1.15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        icon: const Icon(Icons.schedule, size: 20),
                        label: const Text(
                          'Save for Later',
                          style: TextStyle(
                            fontFamily: 'Arimo',
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
