class ReviewCategoryModel {
  int? id;
  String? name;
  String? createdAt;
  int? percent;

  ReviewCategoryModel({
    this.id,
    this.name,
    this.createdAt,
    this.percent,
  });

  factory ReviewCategoryModel.fromJson(Map<String, dynamic> json) {
    return ReviewCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: json['created_at'] as String,
    );
  }
}
