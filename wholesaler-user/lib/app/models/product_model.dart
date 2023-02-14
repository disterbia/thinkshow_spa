import 'dart:math';

import 'package:get/state_manager.dart';
import 'package:wholesaler_user/app/models/product_cloth_caring_guide.dart';
import 'package:wholesaler_user/app/models/product_cloth_detail_spec.dart';
import 'package:wholesaler_user/app/models/product_materials.dart';
import 'package:wholesaler_user/app/models/product_model_info.dart';
import 'package:wholesaler_user/app/models/product_option_model.dart';
import 'package:wholesaler_user/app/models/product_sizes_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';

class Product {
  int id; // 제품 ID
  String title; // 제품명
  int? price; // 가격
  int? normalPrice; //원가
  int? priceDiscountPercent ;//할인율
  int? selectedOptionAddPrice; // 옵션 추가 가격
  int? selectedOptionId;
  String imgUrl;
  List<String>? images;
  List<String>? imagesColor;
  double? imgHeight;
  double? imgWidth;
  int? orderNum; // 회
  String? OLD_option; // 옵션
  RxInt? quantity; // 수량
  bool showQuantityPlusMinus; // Shopping Basket page: button to plus minus quantity of product
  int? soldQuantity;
  RxBool? isTop10;
  RxBool? isChecked;
  RxBool? isSoldout = false.obs; // 품질
  RxBool? isLiked;
  bool? isPrivilege;
  List<String>? category;
  int? mainCategoryId;
  int? subCategoryId;
  Store store;
  RxBool? hasBellIconAndBorder;
  RxDouble? totalRating;
  int? orderStatus;
  bool? isReviewWritten;
  List<ProductOptionModel>? options;
  RxBool? isCheckboxSelected; // Cart1 page
  int? cartId;
  int? totalCount; // used for 노출수, 클릭수, 찜수 inside 매출관리 page
  String? createdAt;
  RxString? content;
  List<ProductSizeModel>? sizes;
  ProductClothDetailSpec? clothDetailSpec;
  ProductClothCaringGuide? clothCaringGuide;
  ProductModelInfo? productModelInfo;
  String? return_exchange_info;
  List<String>? colors;
  List<ProductMaterial>? materials;
  int? orderDetailId;
  String? delivery_invoice_number;
  String? delivery_company_name;
  String? country;
  List<dynamic>? keyword;

  Product({
    required this.id,
    required this.title,
    this.price,
    this.country,
    this.keyword,
    this.normalPrice,
    this.isPrivilege,
    this.priceDiscountPercent,
    required this.imgUrl,
    this.images,
    this.imagesColor,
    this.orderNum, // 회
    this.OLD_option,
    this.quantity,
    this.showQuantityPlusMinus = false,
    this.soldQuantity,
    this.isTop10,
    this.isSoldout,
    this.category,
    this.mainCategoryId,
    this.subCategoryId,
    required this.store,
    this.selectedOptionAddPrice,
    this.imgHeight,
    this.imgWidth,
    this.isLiked,
    this.hasBellIconAndBorder,
    this.totalRating,
    this.isChecked,
    this.orderStatus,
    this.isReviewWritten,
    this.options,
    this.isCheckboxSelected,
    this.cartId,
    this.selectedOptionId,
    this.totalCount,
    this.createdAt,
    this.content,
    this.sizes,
    this.clothDetailSpec,
    this.clothCaringGuide,
    this.productModelInfo,
    this.return_exchange_info,
    this.colors,
    this.materials,
    this.orderDetailId,
    this.delivery_company_name,
    this.delivery_invoice_number
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "imgUrl": imgUrl,
      };
}
