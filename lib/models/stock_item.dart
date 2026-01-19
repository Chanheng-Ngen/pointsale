class StockItem {
  final String id;
  final String name;
  final String sku;
  final String category;
  int current;
  final int min;
  final int max;
  String lastRestocked;
  String status;

  StockItem({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.current,
    required this.min,
    required this.max,
    required this.lastRestocked,
    required this.status,
  });
}
