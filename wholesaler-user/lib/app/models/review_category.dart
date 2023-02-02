class ReviewCategoryModel {
  int? id;
  String? name;
  String? createdAt;

  ReviewCategoryModel({
    this.id,
    this.name,
    this.createdAt,
  });

  factory ReviewCategoryModel.fromJson(Map<String, dynamic> json) {
    return ReviewCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: json['created_at'] as String,
    );
  }
}
