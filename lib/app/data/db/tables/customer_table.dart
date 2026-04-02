class CustomerTable {
  static const table = "customer";

  static const id = "id";
  static const name = "name";
  static const address = "address";
  static const gender = "gender";
  static const createdAt = "created_at";
  static const dateOfBirth = "date_of_birth";
  static const isSynced = "is_synced";

  static const create =
      '''
    CREATE TABLE $table (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $name TEXT,
      $address TEXT,
      $gender TEXT,
      $createdAt TEXT,
      $dateOfBirth TEXT,
      $isSynced INTEGER DEFAULT 0
    )
  ''';
}
