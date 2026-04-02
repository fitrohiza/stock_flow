class BrandTable {
  static const table = "brand";

  static const id = "id";
  static const name = "name";
  static const createdAt = "created_at";
  static const isSynced = "is_synced";

  static const create =
      '''
    CREATE TABLE $table (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $name TEXT,
      $createdAt TEXT ,
      $isSynced INTEGER DEFAULT 0
    )
  ''';
}
