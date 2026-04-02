class ProductTable {
  static const table = "product";

  static const id = "id";
  static const code = "code";
  static const name = "name";
  static const brandId = "brand_id";
  static const createdAt = "created_at";
  static const isSynced = "is_synced";

  static const create =
      '''
    CREATE TABLE $table (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $code TEXT,
      $name TEXT,
      $brandId INTEGER,
      $createdAt TEXT,
      $isSynced INTEGER DEFAULT 0,
      FOREIGN KEY ($brandId) REFERENCES brand(id)
    )
  ''';
}
