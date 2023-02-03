import 'package:wholesaler_user/app/models/product_model.dart';

class ReviewModel2 {
  int? id;
  int? user_id;
  int? store_id;
  int? product_id;
  int? product_option_id;
  int? order_id;
  int? order_detail_id;
  int? category_fit_id;
  int? category_color_id;
  int? category_quality_id;
  String? content;
  String? image_file_path;
  int? star;
  String? created_at;
  Product? product_info;

  ReviewModel2({
    this.id,
    this.user_id,
    this.store_id,
    this.product_id,
    this.product_option_id,
    this.order_id,
    this.order_detail_id,
    this.category_fit_id,
    this.category_color_id,
    this.category_quality_id,
    this.content,
    this.image_file_path,
    this.star,
    this.created_at,
    this.product_info,
  });

  factory ReviewModel2.fromJson(Map<String, dynamic> json) {
    return ReviewModel2(
      id: json['id'] as int,
      user_id: json['user_id'] as int,
      store_id: json['store_id'] as int,
      product_id: json['product_id'] as int,
      product_option_id: json['product_option_id'] as int,
      order_id: json['order_id'] as int,
      order_detail_id: json['order_detail_id'] as int,
      category_fit_id: json['category_fit_id'] as int,
      category_color_id: json['category_color_id'] as int,
      category_quality_id: json['category_quality_id'] as int,
      content: json['content'] as String,
      image_file_path: json['image_file_path'] as String,
      star: json['star'] as int,
      created_at: json['created_at'] as String,
      // product_info: json['product_info'] as Product,
    );
  }
}
