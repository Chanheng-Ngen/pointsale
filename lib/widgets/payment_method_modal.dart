import 'package:flutter/material.dart';
import 'package:point_sale/core/constants/app_color.dart';

class PaymentMethodModal extends StatefulWidget {
  final double totalAmount;

  const PaymentMethodModal({
    super.key,
    required this.totalAmount,
  });

  @override
  State<PaymentMethodModal> createState() => _PaymentMethodModalState();
}

class _PaymentMethodModalState extends State<PaymentMethodModal> {
  String selectedPaymentMethod = 'Credit/Debit Card';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.whiteWithOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Payment Method',
                  style: TextStyle(
                    fontFamily: 'Arimo',
                    fontSize: 20,
                    color: AppColor.textPrimary,
                    height: 1.4,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 36,
                    height: 36,
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: AppColor.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Payment Methods
            Column(
              children: [
                // Credit/Debit Card
                _buildPaymentOption(
                  icon: Icons.credit_card,
                  label: 'Credit/Debit Card',
                  value: 'Credit/Debit Card',
                ),
                const SizedBox(height: 12),
                // Cash
                _buildPaymentOption(
                  icon: Icons.money,
                  label: 'Cash',
                  value: 'Cash',
                ),
                const SizedBox(height: 12),
                // Digital Wallet
                _buildPaymentOption(
                  icon: Icons.account_balance_wallet,
                  label: 'Digital Wallet',
                  value: 'Digital Wallet',
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Amount to Pay
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColor.whiteWithOpacity(0.9),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Amount to Pay',
                    style: TextStyle(
                      fontFamily: 'Arimo',
                      fontSize: 16,
                      color: AppColor.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    '\$${widget.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontFamily: 'Arimo',
                      fontSize: 24,
                      color: AppColor.primary,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                // Cancel Button
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF0A0A0A),
                        side: const BorderSide(
                          color: AppColor.borderMedium,
                          width: 1.15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontFamily: 'Arimo',
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Confirm Button
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, selectedPaymentMethod);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        foregroundColor: AppColor.whiteWithOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Confirm Payment',
                        style: TextStyle(
                          fontFamily: 'Arimo',
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String label,
    required String value,
  }) {
    final isSelected = selectedPaymentMethod == value;

    return InkWell(
      onTap: () {
        setState(() {
          selectedPaymentMethod = value;
        });
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF00B8DB).withOpacity(0.15)
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF00B8DB)
                : const Color(0xFFE5E7EB),
            width: 1.15,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: const Color(0xFF0A0A0A),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Arimo',
                  fontSize: 16,
                  color: Color(0xFF0A0A0A),
                  height: 1.5,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check,
                size: 20,
                color: Color(0xFF00B8DB),
              ),
          ],
        ),
      ),
    );
  }
}
