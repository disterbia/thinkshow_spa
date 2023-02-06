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
  List<String>? image_file_path;
  int? star;
  String? created_at;
  Product? product_info;

  String? category_fit_name;
  String? category_color_name;
  String? category_quality_name;
  String? select_option_name;

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
    this.category_fit_name,
    this.category_color_name,
    this.category_quality_name,
    this.select_option_name,
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
      image_file_path: json['image_file_path'] != null
          ? json['image_file_path']?.cast<String>() as List<String>
          : null,
      star: json['star'] as int,
      created_at: json['created_at'] as String,
      // product_info: json['product_info'] as Product,
      category_fit_name: json['category_fit_name'] as String,
      category_color_name: json['category_color_name'] as String,
      category_quality_name: json['category_quality_name'] as String,
      select_option_name: json['select_option_name'] as String,
    );
  }
}
