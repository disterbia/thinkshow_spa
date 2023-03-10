import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wholesaler_partner/app/models/product_inquiry_model.dart';
import 'package:wholesaler_partner/app/modules/product_inquiry_detail/view/product_inquiry_detail_view.dart';
// import 'package:wholesaler_user/app/Constants/colors.dart';
import 'package:wholesaler_user/app/Constants/styles.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/product_number_model.dart';
import 'package:wholesaler_user/app/models/review.dart';
import 'package:wholesaler_user/app/models/review_mdoel2.dart';
import 'package:wholesaler_user/app/models/review_model.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart1_shopping_basket_controller.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/views/review_detail_view2.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/Product_detail_view.dart';
import 'package:wholesaler_user/app/modules/review_detail/views/review_detail_view.dart';
import 'package:wholesaler_user/app/widgets/dialog.dart';
import 'package:wholesaler_user/app/widgets/product/number_widget.dart';
import 'package:wholesaler_user/app/widgets/product/quantity_plus_minus_widget.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';
import '../../modules/product_detail/controller/product_detail_controller.dart';

class ProductItemHorizontal extends StatelessWidget {
  late Product product;
  ProductNumber? productNumber;
  Review? review;
  int? price;
  // int? totalPrice;
  // int? normalPrice;
  // int? discountPercent;
  // int? normalTotalPrice;
  TextStyle? titleStyle;
  ProductInquiry? inquiry;
  Function(bool)? quantityPlusMinusOnPressed;
  late bool showClose;
  late bool showPrice;

  /// Ues for all pages except *Review pages*
  ProductItemHorizontal({
    required this.product,
    this.productNumber,
    this.quantityPlusMinusOnPressed,
    this.price,
    required this.showClose,
    required this.showPrice,

    // this.normalPrice,
    // this.discountPercent,
    // this.totalPrice,
    // this.normalTotalPrice
  });

  /// Use for Review List, Review Detail Pages
  ProductItemHorizontal.review(
      {required Review review,
      required bool showClose,
      required bool showPrice,
      titleStyle}) {
    this.product = review.product;
    this.review = review;
    this.titleStyle = titleStyle;
    this.showClose = showClose;
    this.showPrice = showPrice;
  }

  /// Use for Review List, Review Detail Pages
  ProductItemHorizontal.inquiry({
    required ProductInquiry inquiry,
    required bool showClose,
    required bool showPrice,
  }) {
    this.product = inquiry.product;
    this.inquiry = inquiry;
    this.showClose = showClose;
    this.showPrice = showPrice;
  }

  @override
  Widget build(BuildContext context) {
    int normalPrice = product.normalPrice??0;
    int productTotalPrice = 0;
    int normalTotalPrice = 0;
    if (product.quantity != null) {
      if (product.price != null) {
        productTotalPrice = (product.price! + product.selectedOptionAddPrice!) *
            product.quantity!.value;
      } else {
        productTotalPrice = (price! + product.selectedOptionAddPrice!) *
            product.quantity!.value;
      }

      normalTotalPrice = (normalPrice + product.selectedOptionAddPrice!) *
          product.quantity!.value;
    }

    return GestureDetector(
      onTap: () {
        if (inquiry != null) {
          Get.to(() => ProductInquiryDetailView(inquiry!));
          return;
        }

        if (review != null) {
          log('review != null great');
          // Get.to(() => ReviewDetailView(
          //       selectedReviw: review!,
          //       isComingFromReviewPage: true,
          //     ));

          Get.to(
            () => ReviewDetailView2(
              review: ReviewModel2(
                image_file_path: review!.images,
                product_info: review!.product,
                content: review!.content,
                select_option_name: review!.product.OLD_option,
                category_fit_name: review!.category_fit_name,
                category_color_name: review!.category_color_name,
                category_quality_name: review!.category_quality_name,
                star: review!.rating.toInt(),
              ),
            ),
          );
          return;
        }
        if (product.id != -1) {
          //print("${product.id}asdfasdf");
          Get.delete<ProductDetailController>();
          Get.to(() => ProductDetailView(), arguments: product.id);
        }
      },
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageBuilder(),
              SizedBox(
                height: 10,
              ),
              QuantityPlusMinusBuilder(),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category
                // CategoryBuilder(),
                // Store Name
                //StoreNameBuilder(),
                // Title
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 10, child: TitleBuilder()),
                    Spacer(),
                    showClose
                        ? Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  mDialog(
                                    title: '선택삭제',
                                    subtitle: '선택하셨던 상품을 삭제하시겠습니까?',
                                    twoButtons: TwoButtons(
                                      leftBtnText: '취소',
                                      rightBtnText: '삭제',
                                      lBtnOnPressed: () {
                                        Get.back();
                                      },
                                      rBtnOnPressed: () => Get.find<
                                              Cart1ShoppingBasketController>()
                                          .oneDelete(
                                              product.cartId!),
                                    ),
                                  );
                                },
                                child: Icon(Icons.clear)),
                          )
                        : SizedBox.shrink()
                  ],
                ),
                // Option
                //OptionBuilder(),
                // Option with extra price
                OptionExtraPriceBuilder(),
                // Quantity plus minus buttons
                //QuantityPlusMinusBuilder(),
                // Quantity
                //QuantityBuilder(),
                // Price
                //PriceBuilder(),
                showPrice
                    ? Row(
                        children: [
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    product.priceDiscountPercent.toString() +
                                        "% ",
                                    style: TextStyle(color: MyColors.primary),
                                  ),
                                  Text(
                                      Utils.numberFormat(
                                          number: normalTotalPrice,
                                          suffix: '원'),
                                      style: TextStyle(
                                          color: MyColors.grey4,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'SpoqaHanSansNeo-Medium',
                                          fontSize: 12.0,
                                          decoration:
                                              TextDecoration.lineThrough)),
                                ],
                              ),
                              Text(
                                Utils.numberFormat(
                                    number: productTotalPrice, suffix: '원'),
                                style: MyTextStyles.f18_cart,
                              )
                            ],
                          ),
                        ],
                      )
                    : SizedBox.shrink()
                // Total Count
                //  TotalCountBuilder(),
                // Sold Quantity
                //SoldQuantityBuilder(),
                // Inquiry Text
                //InquiryBuilder(context),
                // Review Text
                //ReviewBuilder(),
                // RatingType1
                //RatingType1Builder(),
                // RatingType2
                //RatingType2Builder(),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  ImageBuilder() {
    // print(product.imgUrl);
    // print(product.imgUrl);
    // print(product.imgUrl);
    // String result = product.imgUrl.substring(0, product.imgUrl.indexOf(','));

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: ExtendedImage.network(
        product.imgUrl.contains(",")
            ? product.imgUrl.substring(0, product.imgUrl.indexOf(','))
            : product.imgUrl,
        clearMemoryCacheWhenDispose:true,enableMemoryCache:false,enableLoadState: false,
        //cacheWidth:70,
        //cacheHeight: 70,
        fit: BoxFit.fitWidth,
        height: 70,
        width: 70,
        // placeholder: (context, url) => CircularProgressIndicator(),
      ),
    );
  }

  NumberTopLeftBuilder() {
    if (productNumber != null) {
      return NumberWidget(productNumber!);
    }
    return SizedBox.shrink();
  }

  CategoryBuilder() {
    if (product.category != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Text(product.category![0]),
            SizedBox(width: 3),
            Icon(
              Icons.arrow_forward_ios,
              size: 10,
            ),
            SizedBox(width: 3),
            Text(product.category![1]),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }

  StoreNameBuilder() {
    if (product.store.name != null) {
      return Text(product.store.name!);
    }
    return SizedBox.shrink();
  }

  TitleBuilder() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(maxLines: 2,overflow:TextOverflow.ellipsis,
        product.title,
        // overflow: TextOverflow.ellipsis,
        style: MyTextStyles.f14,
      ),
    );
  }

  OptionBuilder() {
    // Why we check product.optionExtraPrice is null or not? The reason is because on [장바구니] shopping basket page,
    // we want to show OptionExtraPriceBuilder but we don't want to show OptionBuilder.
    if (product.OLD_option != null && product.selectedOptionAddPrice == null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Text('option'.tr),
            SizedBox(width: 15),
            Text(product.OLD_option!),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }

  OptionExtraPriceBuilder() {
    if (product.selectedOptionAddPrice != null && product.OLD_option != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Text(
              product.OLD_option!,
              style: MyTextStyles.f14.copyWith(color: MyColors.grey4),
            ),
            SizedBox(width: 10),
            Text(
              '+${product.selectedOptionAddPrice!.toString()}',
              style: MyTextStyles.f14.copyWith(color: MyColors.grey4),
            ),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }

  QuantityPlusMinusBuilder() {
    if (product.showQuantityPlusMinus == true) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: QuantityPlusMinusWidget(
          quantity: product.quantity != null ? product.quantity!.value : -1,
          onTap: (isRightTapped) => quantityPlusMinusOnPressed!(isRightTapped),
        ),
      );
    }
    return SizedBox.shrink();
  }

  QuantityBuilder() {
    if (product.quantity != null && product.showQuantityPlusMinus == false) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Text('quantity'.tr),
            SizedBox(width: 15),
            Text('${product.quantity!.toString()}개'),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }

  PriceBuilder() {
    if (product.price != null) {
      final currencyFormat = NumberFormat("#,##0", "en_US");
      String price = currencyFormat.format(product.price);
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Text(
              price,
              style: MyTextStyles.f16_bold.copyWith(color: MyColors.black2),
            ),
            Text(
              '원',
              style: MyTextStyles.f14.copyWith(color: MyColors.black2),
            ),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }

  TotalCountBuilder() {
    if (product.totalCount != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Text(
              Utils.numberFormat(number: product.totalCount!),
              // '${product.totalCount}',
              style: MyTextStyles.f16_bold.copyWith(color: MyColors.black2),
            ),
            Text(
              '회',
              style: MyTextStyles.f16.copyWith(color: MyColors.black2),
            )
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  SoldQuantityBuilder() {
    if (product.soldQuantity != null) {
      return Text('${product.soldQuantity.toString()}회');
      // return Text('${Utils.numberFormat(number: product.soldQuantity!)}회');
    }
    return SizedBox.shrink();
  }

  InquiryBuilder(context) {
    if (inquiry != null) {
      return Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 150,
            child: Text(
              inquiry!.question,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
              style: MyTextStyles.f16.copyWith(color: MyColors.black2),
            ),
          ),
          SizedBox(height: 5),
        ],
      );
    }
    return SizedBox.shrink();
  }

  ReviewBuilder() {
    if (review != null) {
      return Column(
        children: [
          Text(
            review!.content,
            style: MyTextStyles.f16.copyWith(color: MyColors.black2),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5),
        ],
      );
    }
    return SizedBox.shrink();
  }

  RatingType1Builder() {
    if (review != null && review!.ratingType == ProductRatingType.number) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          SizedBox(width: 5),
          Text(review!.rating.toString()),
        ],
      );
    }
    return SizedBox.shrink();
  }

  RatingType2Builder() {
    if (review != null && review!.ratingType == ProductRatingType.star) {
      return RatingBar.builder(
        itemSize: 20,
        ignoreGestures: true,
        initialRating: review!.rating,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        // itemPadding: EdgeInsets.symmetric(horizontal: 2),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: MyColors.orange3,
        ),
        onRatingUpdate: (rating) {},
      );
    }
    return SizedBox.shrink();
  }
}
