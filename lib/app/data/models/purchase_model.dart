class PurchaseModel {
  final int? id;
  final int customerId;
  final int productId;
  final String orderDate;
  final int qty;
  final int isSynced;

  PurchaseModel({
    this.id,
    required this.customerId,
    required this.productId,
    required this.orderDate,
    required this.qty,
    this.isSynced = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "customer_id": customerId,
      "product_id": productId,
      "order_date": orderDate,
      "qty": qty,
      "is_synced": isSynced,
    };
  }

  factory PurchaseModel.fromMap(Map<String, dynamic> map) {
    return PurchaseModel(
      id: map["id"],
      customerId: map["customer_id"] ?? 0,
      productId: map["product_id"] ?? 0,
      orderDate: map["order_date"] ?? "",
      qty: map["qty"] ?? 0,
      isSynced: map["is_synced"] ?? 0,
    );
  }
}
