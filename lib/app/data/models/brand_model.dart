class BrandModel {
  final int? id;
  final String name;
  final String? createdAt;
  final int isSynced;

  BrandModel({this.id, required this.name, this.createdAt, this.isSynced = 0});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "created_at": createdAt,
      "is_synced": isSynced,
    };
  }

  Map<String, dynamic> toMapUpdate() {
    return {"id": id, "name": name};
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      id: map["id"],
      name: map["name"] ?? "",
      createdAt: map["created_at"] ?? "",
      isSynced: map["is_synced"] ?? 0,
    );
  }
}
