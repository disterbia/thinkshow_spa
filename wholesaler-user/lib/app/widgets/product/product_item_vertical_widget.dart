// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/constants.dart';
import 'package:wholesaler_user/app/constants/functions.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/product_number_model.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/modules/page4_favorite_products/controllers/page4_favorite_products_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/Product_detail_view.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/product/number_widget.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

import '../../modules/product_detail/controller/product_detail_controller.dart';

class ProductItemVertical extends StatelessWidget {
  final Product product;
  final ProductNumber? productNumber;
  Function(bool?)? onCheckboxChanged;
  bool? isFavorite;
  bool? onlyPhoto;
  int? crossAxisCount;
  ProductItemVertical({
    required this.product,
    this.productNumber,
    this.onCheckboxChanged,
    this.isFavorite,
    this.onlyPhoto = false,
    this.crossAxisCount,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        //print('inside ProductItemVertical: ' + product.id.toString());
        Get.delete<ProductDetailController>();
        Get.to(() => ProductDetailView(), arguments: product.id, preventDuplicates: false);
      }),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(alignment: Alignment.center,
            child: Stack(
              children: [
                // Image
                ImageBuilder(),
                // Checkbox
                CheckboxBuilder(),
                // TopLeft Number
                NumberTopLeftBuilder(),
                // LikeIconBuilder (heart icon)
                LikeIconBuilder(),
                // isSoldout
                SoldOutBuilder(),
                // Top left bell icon
                GoldenBorderBellIconBuilder(),
              ],
            ),
          ),
          // The reason for using this column is to align children to the left.
          !onlyPhoto!
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    // Store Name
                    StoreNameBuilder(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Title
                        TitleBuilder(),
                        // Top 10 Text
                        //Top10TextBuilder(),
                      ],
                    ),
                    SizedBox(height: 5),
                    // Price
                    PriceBuilder(),
                  ],
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  BoxDecoration GoldenBorderDecorationBuilder() {
    BorderRadius imageBorderRadius = BorderRadius.only(
      topRight: Radius.circular(8),
      bottomRight: Radius.circular(8),
      bottomLeft: Radius.circular(8),
    );
    return BoxDecoration(
      borderRadius: imageBorderRadius,
      // border: Border.all(color: MyColors.accentColor, width: 2),
    );
  }

  ImageBuilder() {
    return Column(
      children: [
        // we need this to ensure the image is located south of the bell icon.
        // SizedBox(height: 18),
        product.hasBellIconAndBorder != null
            ? Obx(
                () => Container(
                  height: product.imgHeight ?? (GetPlatform.isMobile?Get.width/3:500/3),
                  width:GetPlatform.isMobile? double.infinity:500,
                  // width: product.imgWidth ?? mConst.fixedImgWidth,
                  decoration: product.hasBellIconAndBorder!.isTrue
                      ? GoldenBorderDecorationBuilder()
                      : null,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FittedBox(
                      child: ExtendedImage.network(clearMemoryCacheWhenDispose:true,enableMemoryCache:false, enableLoadState: false,
                        product.imgUrl,
                        //cacheWidth:(500).ceil() ,
                        //cacheHeight: (product.imgHeight??500/3).ceil(),
                        // placeholder: (context, url) => null,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )
            : Container(
                height: product.imgHeight ?? (GetPlatform.isMobile?Get.width/3:500/3),
                width: GetPlatform.isMobile? double.infinity:500,
                // width: product.imgWidth ?? mConst.fixedImgWidth,
                decoration: null,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FittedBox(
                    child: ExtendedImage.network(clearMemoryCacheWhenDispose:true,enableMemoryCache:false, enableLoadState: false,
                       product.imgUrl,
                      //cacheWidth:500.ceil() ,
                      //cacheHeight: (product.imgHeight??500/3).ceil(),
                      // placeholder: (context, url) => null,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
      ],
    );
  }

  CheckboxBuilder() {
    if (product.isChecked != null) {
      // print('inside CheckboxBuilder');
      return Container(
        margin: EdgeInsets.only(left: 2, top: 2),
        height: 25,
        width: 25,
        child: Obx(
          () => Checkbox(
            value: product.isChecked!.value,
            onChanged: onCheckboxChanged,
          ),
        ),
      );
    }
    return SizedBox.shrink();
  }

  LikeIconBuilder() {
    return MyVars.isUserProject()
        ? Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () async {
                //
                if (CacheProvider().getToken().isEmpty) {
                  mSnackbar(message: '로그인 후 이용 가능합니다.');
                  mFuctions.userLogout();
                  return;
                }

                bool result = await uApiProvider().chekToken();
                if (!result) {
                  print('logout');
                  mSnackbar(message: '로그인 후 이용 가능합니다.');
                   mFuctions.userLogout();
                  return;
                }
                product.isLiked!.toggle();
                uApiProvider().putProductLikeToggle(productId: product.id);
                if (product.isLiked!.isTrue) {
                  mSnackbar(message: '찜 완료', duration: 1);
                } else {
                  mSnackbar(message: '찜 취소 완료', duration: 1);

                  // if (isFavorite != null && isFavorite!) {
                  //     Page4Favorite_RecentlyViewedController ctr = Get.put(Page4Favorite_RecentlyViewedController());
                  //     ctr.updateProducts();
                  //     ctr.dispose();
                  // }
                }
              },
              child: product.isLiked != null
                  ? Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          product.isLiked != null && product.isLiked!.value
                              ? 'assets/icons/ico_heart_on.png'
                              : 'assets/icons/ico_heart_off.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ),
          )
        : SizedBox.shrink();
  }

  NumberTopLeftBuilder() {
    if (productNumber != null) {
      return NumberWidget(productNumber!);
    }
    return SizedBox.shrink();
  }

  Top10TextBuilder() {
    if (product.isTop10 != null) {
      return Obx(() => product.isTop10 == true
          ? Text(
              'TOP10',
              style: TextStyle(color: Colors.red, fontSize: 12),
            )
          : SizedBox.shrink());
    }
    return SizedBox.shrink();
  }

  StoreNameBuilder() {
    if (product.store.name != null) {
      return Text(
        product.store.name!,
        maxLines: 1,
        style: MyTextStyles.f14.copyWith(color:Colors.black,fontSize: crossAxisCount==2?16:14),
        overflow: TextOverflow.ellipsis,
      );
    }
    return SizedBox.shrink();
  }

  TitleBuilder() {
    return Flexible(
      child: Text(
        product.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: MyTextStyles.f12.copyWith(color: MyColors.black1,fontSize: crossAxisCount==2?14:12),
      ),
    );
  }

  PriceBuilder() {
    if (product.price != null) {
      final currencyFormat = NumberFormat("#,##0", "en_US");
      String price = currencyFormat.format(product.price);
      return Column(
        children: [
          Row(
            children: [
              Flexible(
                  child: Text(maxLines: 1,
                "띵 할인가 ",
                style: TextStyle(fontSize: crossAxisCount==2?14:12, color: Colors.redAccent,overflow: TextOverflow.ellipsis,),
              )),
              Flexible(
                child: Text(maxLines: 1,
                  Utils.numberFormat(number: product.normalPrice ?? 0),
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: MyColors.grey4,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'SpoqaHanSansNeo-Medium',
                      fontSize: crossAxisCount==2?14:12,
                      decoration: TextDecoration.lineThrough),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Text("${product.priceDiscountPercent ?? 0}% ",
                  // Utils.numberFormat(
                  //     number: product.priceDiscountPercent ?? 0, suffix: '% ').toString(),
                  style: MyTextStyles.f18_bold.copyWith(
                      color: MyColors.primary2,
                      fontSize: crossAxisCount==2?16:14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                flex: 3,
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  Utils.numberFormat(
                    number: product.price ?? 0,
                  ),
                  style: MyTextStyles.f18_bold
                      .copyWith(fontSize: crossAxisCount==2?16:14, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      );
    }
    return SizedBox.shrink();
  }

  SoldOutBuilder() {
    return product.isSoldout != null
        ? Obx(
            () => product.isSoldout!.isTrue
                ? Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      height: 24,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Center(
                        child: Text(
                          '품절',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          )
        : SizedBox.shrink();
  }

  GoldenBorderBellIconBuilder() {
    return product.hasBellIconAndBorder != null
        ? Obx(
            () => product.hasBellIconAndBorder!.isTrue
                ? Positioned(
                  bottom: 12,
                  left: 6,
                  child: Image.asset(
                      'assets/icons/ico_dingdong.png',
                      height: 20,
                    ),
                )
                // Container(
                //     width: 24,
                //     height: 23,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(4),
                //         topRight: Radius.circular(4),
                //       ),
                //       color: MyColors.accentColor,
                //     ),
                //     child: Icon(
                //       Icons.notifications,
                //       color: MyColors.white,
                //       size: 14,
                //     ),
                //   )
                : SizedBox.shrink(),
          )
        : SizedBox.shrink();
  }
}
