class OrderEntity {
  final String id;
  final String itemName;
  final int quantity;
  final String status;

  OrderEntity({
    required this.id,
    required this.itemName,
    required this.quantity,
    required this.status,
  });
}
