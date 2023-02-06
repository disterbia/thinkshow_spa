import 'package:wholesaler_user/app/models/review_category.dart';

class ReviewInfoModel {
  int? review_total_count;
  double? avg_star;
  int? review_photo_count;
  Map<String, ReviewCategoryModel>? reviewCategoryModel = {};

  ReviewInfoModel({
    this.avg_star,
    this.review_photo_count,
    this.review_total_count,
  });

  factory ReviewInfoModel.fromJson(Map<String, dynamic> json) {
    return ReviewInfoModel(
      review_total_count: json['review_total_count'] as int,
      avg_star: double.parse(json['avg_star'] as String),
      review_photo_count: json['review_photo_count'] as int,
    );
  }
}
