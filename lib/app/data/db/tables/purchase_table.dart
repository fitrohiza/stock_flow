class PurchaseTable {
  static const table = "purchase";

  static const id = "id";
  static const customerId = "customer_id";
  static const productId = "product_id";
  static const orderDate = "order_date";
  static const qty = "qty";
  static const isSynced = "is_synced";

  static const create =
      '''
    CREATE TABLE $table (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $customerId INTEGER,
      $productId INTEGER,
      $orderDate TEXT,
      $qty INTEGER,
      $isSynced INTEGER DEFAULT 0,
      FOREIGN KEY ($customerId) REFERENCES customer(id),
      FOREIGN KEY ($productId) REFERENCES product(id)
    )
  ''';
}
