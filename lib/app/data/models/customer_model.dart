class CustomerModel {
  final int? id;
  final String name;
  final String address;
  final String gender;
  final String? createdAt;
  final String dateOfBirth;
  final int isSynced;

  CustomerModel({
    this.id,
    required this.name,
    required this.address,
    required this.gender,
    this.createdAt,
    required this.dateOfBirth,
    this.isSynced = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "address": address,
      "gender": gender,
      "created_at": createdAt,
      "date_of_birth": dateOfBirth,
      "is_synced": isSynced,
    };
  }

  Map<String, dynamic> toMapUpdate() {
    return {
      "id": id,
      "name": name,
      "address": address,
      "gender": gender,
      "date_of_birth": dateOfBirth,
      "is_synced": isSynced,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map["id"],
      dateOfBirth: map["date_of_birth"] ?? "",
      name: map["name"] ?? "",
      address: map["address"] ?? "",
      gender: map["gender"] ?? "",
      createdAt: map["created_at"] ?? "",
      isSynced: map["is_synced"] ?? 0,
    );
  }
}
