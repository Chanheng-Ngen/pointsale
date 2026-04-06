class OrderModel {
  final String id;
  final String customerName;
  final String status; // 'pending', 'completed', 'cancelled'
  final int itemCount;
  final String time;
  final double subtotal;
  final double tax;
  final double total;

  OrderModel({
    required this.id,
    required this.customerName,
    required this.status,
    required this.itemCount,
    required this.time,
    required this.subtotal,
    required this.tax,
    required this.total,
  });
}
