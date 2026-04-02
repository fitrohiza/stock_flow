class ProductModel {
  final int? id;
  final String code;
  final String name;
  final int brandId;
  final String createdAt;
  final int isSynced;

  ProductModel({
    this.id,
    required this.code,
    required this.name,
    required this.brandId,
    required this.createdAt,
    this.isSynced = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "code": code,
      "name": name,
      "brand_id": brandId,
      "created_at": createdAt,
      "is_synced": isSynced,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map["id"],
      code: map["code"] ?? "",
      name: map["name"] ?? "",
      brandId: map["brand_id"] ?? 0,
      createdAt: map["created_at"] ?? "",
      isSynced: map["is_synced"] ?? 0,
    );
  }
}
