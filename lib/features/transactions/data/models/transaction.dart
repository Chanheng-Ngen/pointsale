class Transaction {
  final String id;
  final String type;
  final String description;
  final String paymentMethod;
  final String time;
  final double amount;

  Transaction({
    required this.id,
    required this.type,
    required this.description,
    required this.paymentMethod,
    required this.time,
    required this.amount,
  });
}
