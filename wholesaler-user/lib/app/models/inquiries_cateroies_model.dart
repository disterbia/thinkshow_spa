class InquiriesCategoiesModel {
  int? id;
  String? name;
  String? createdAt;

  InquiriesCategoiesModel({
    this.id,
    this.name,
    this.createdAt,
  });

  factory InquiriesCategoiesModel.fromJson(Map<String, dynamic> json) {
    return InquiriesCategoiesModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      createdAt: json['created_at'] as String,
    );
  }
}
