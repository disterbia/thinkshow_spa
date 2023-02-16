// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/review.dart';
import 'package:wholesaler_user/app/models/review_category.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart1_shopping_basket_controller.dart';
import 'package:wholesaler_user/app/modules/cart/views/cart1_shopping_basket_view.dart';
import 'package:wholesaler_user/app/modules/review_detail/controllers/review_detail_controller.dart';
import 'package:wholesaler_user/app/modules/search/views/search_page_view.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_horiz_widget.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

class ReviewDetailView extends GetView {
  ReviewDetailController ctr = Get.put(ReviewDetailController());
  Cart1ShoppingBasketController ctr2 = Get.put(Cart1ShoppingBasketController());

  bool isEditing;

  ReviewDetailView(
      {this.isEditing = false,
      required Review selectedReviw,
      Product? product,
      required bool isComingFromReviewPage}) {
    ctr.init(
        tempSelectedReviw: selectedReviw,
        isComingFromOrderInquiryPage: isComingFromReviewPage);

    ctr.getReviewCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: _appbar(),
      body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: _body()),
    );
  }

  Widget _body() {
    print('ctr.selectedReviw!.value');
    print(ctr.selectedReviw!.value);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            _userId(),
            SizedBox(height: 10),
            Obx(
              () => _productReviewView(),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: MyColors.grey1,
            ),
            // Obx(() => ctr.price != (-1) ? _productItemBuilder() : Container()),
            // SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     _rateBar(),
            //     _date(),
            //   ],
            // ),
            SizedBox(
              height: 5,
            ),
            Text(
              '착용감을 평가해주세요',
              style: MyTextStyles.f14.copyWith(
                  color: MyColors.black3, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Obx(
              () => ctr.reviewFitCategoryList.isNotEmpty
                  ? Row(
                      children: [
                        for (int i = 0;
                            i < ctr.reviewFitCategoryList.length;
                            i++) ...[
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: _selectCategory(ctr.reviewFitCategoryList[i],
                                i == ctr.selectFitCategoryIndex.value, () {
                              ctr.selectFitCategoryIndex.value = i;
                            }),
                          )
                        ]
                      ],
                    )
                  : SizedBox(),
            ),
            SizedBox(height: 30),
            Text(
              '색감을 평가해주세요',
              style: MyTextStyles.f14.copyWith(
                  color: MyColors.black3, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => ctr.reviewColorCategoryList.isNotEmpty
                  ? Row(
                      children: [
                        for (int i = 0;
                            i < ctr.reviewColorCategoryList.length;
                            i++) ...[
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: _selectCategory(
                                ctr.reviewColorCategoryList[i],
                                i == ctr.selectColorCategoryIndex.value, () {
                              ctr.selectColorCategoryIndex.value = i;
                            }),
                          )
                        ]
                      ],
                    )
                  : SizedBox(),
            ),
            SizedBox(height: 30),

            Text(
              '퀄리티를 평가해주세요',
              style: MyTextStyles.f14.copyWith(
                  color: MyColors.black3, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),

            Obx(
              () => ctr.reviewQualityCategoryList.isNotEmpty
                  ? Row(
                      children: [
                        for (int i = 0;
                            i < ctr.reviewQualityCategoryList.length;
                            i++) ...[
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: _selectCategory(
                                ctr.reviewQualityCategoryList[i],
                                i == ctr.selectQualityCategoryIndex.value, () {
                              ctr.selectQualityCategoryIndex.value = i;
                            }),
                          )
                        ]
                      ],
                    )
                  : SizedBox(),
            ),
            SizedBox(height: 30),

            Text(
              '상세한 리뷰를 남겨주세요',
              style: MyTextStyles.f14.copyWith(
                  color: MyColors.black3, fontWeight: FontWeight.w500),
            ),
            Obx(
              () => _contentCheck(),
            ),

            SizedBox(height: 5),
            _reviewInputfield(),
            SizedBox(height: 30),
            Text(
              '사진을 함께 올려주세요',
              style: MyTextStyles.f14.copyWith(
                  color: MyColors.black3, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            Text(
              '사진을 첨부할 경우 개인정보가 노출되지 않도록 유의해주세요.',
              style: MyTextStyles.f12.copyWith(
                  color: MyColors.grey10, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15),

            // Obx(() => ctr.reviewImageUrl != ''
            //     ? ctr.selectedReviw!.value.reviewImageUrl != null
            //         ? _attachmentPicture()
            //         : MyVars.isUserProject()
            //             ? emptyReviewImageHolder()
            //             : Container()
            //     : emptyReviewImageHolder()),

            Obx(() => ctr.reviewImageUrl.value!.isNotEmpty
                ? _attachmentPicture()
                : emptyReviewImageHolder()),
            SizedBox(height: 50),
            Divider(
              color: MyColors.grey1,
            ),
            SizedBox(height: 10),
            _bottomButtonsBuilder(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _contentCheck() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Icon(
              Icons.check_rounded,
              color: ctr.contentOK.value ? MyColors.primary : MyColors.grey10,
              size: 15,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              '최소 20자',
              style: MyTextStyles.f11.copyWith(
                  color:
                      ctr.contentOK.value ? MyColors.primary : MyColors.grey10,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Row(
          children: [
            Icon(
              Icons.check_rounded,
              color: ctr.photoOK.value ? MyColors.primary : MyColors.grey10,
              size: 15,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              '사진 첨부',
              style: MyTextStyles.f11.copyWith(
                  color: ctr.photoOK.value ? MyColors.primary : MyColors.grey10,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }

  Widget _userId() {
    return MyVars.isUserProject()
        ? SizedBox.shrink()
        : Text(
            ctr.selectedReviw!.value.writer != null
                ? ctr.selectedReviw!.value.writer!
                : "id",
            style: MyTextStyles.f16.copyWith(color: MyColors.black2),
          );
  }

  Widget _selectCategory(ReviewCategoryModel reviewCategoryModel, bool isSelect,
      Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 23),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: isSelect ? MyColors.primary : MyColors.grey1, width: 1.5),
        ),
        child: Text(
          reviewCategoryModel.name!,
          style: MyTextStyles.f12.copyWith(
              color: isSelect ? MyColors.primary : MyColors.grey10,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  // Widget _productItemBuilder() {
  //   int totalPrice = ctr.price.value +
  //       ctr.selectedReviw!.value.product.selectedOptionAddPrice!;

  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.end,
  //     children: [
  //       // ProductItemHorizontal(product: ctr.selectedReviw!.value.product),
  //       Spacer(),
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.end,
  //         children: [
  //           Text(
  //             Utils.numberFormat(number: ctr.price.value, suffix: '원'),
  //             style: MyTextStyles.f12,
  //           ),
  //           SizedBox(height: 5),
  //           Text(
  //             Utils.numberFormat(number: totalPrice, suffix: '원'),
  //             style: MyTextStyles.f16.copyWith(color: MyColors.black2),
  //           ),
  //         ],
  //       )
  //     ],
  //   );
  // }

  Widget _productReviewView() {
    return Container(
      // padding: EdgeInsets.all(15),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              imageUrl: ctr.selectedReviw!.value.product.imgUrl,
              width: 80,
              height: 80,
              fit: BoxFit.fill,
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      ctr.selectedReviw!.value.product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: MyTextStyles.f14.copyWith(
                          color: MyColors.grey10, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: _rateBar(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rateBar() {
    return Obx(
      () => RatingBar.builder(
        ignoreGestures: !MyVars.isUserProject(), // disable gesture to rate
        initialRating: ctr.selectedReviw!.value.rating,
        direction: Axis.horizontal,
        itemSize: 25,
        itemCount: 5,

        itemBuilder: (context, _) => Icon(
          Icons.star_rounded,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          print('rating $rating');
          ctr.selectedReviw!.value.rating = rating;
          print(
              'ctr.selectedReviw!.value.rating ${ctr.selectedReviw!.value.rating}');
        },
      ),
    );
  }

  Widget _date() {
    return Text(
      ctr.selectedReviw!.value.createdAt!,
      style: MyTextStyles.f12.copyWith(color: MyColors.grey2),
    );
  }

  Widget _reviewInputfield() {
    ctr.contentController.text = ctr.selectedReviw!.value.content;

    return TextField(
      onChanged: (value) {
        if (value.length >= 20)
          ctr.contentOK.value = true;
        else
          ctr.contentOK.value = false;
      },
      readOnly: !MyVars.isUserProject(),
      controller: ctr.contentController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        hintText: '착용감, 색감, 퀄리티 등 자세한 후기를 남겨주시면 다른 구매자들에게도 도움이 됩니다.',
        hintStyle: MyTextStyles.f12
            .copyWith(color: MyColors.grey10, fontWeight: FontWeight.w500),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyDimensions.radius),
        ),
      ),
      maxLines: 5,
    );
  }

  Widget emptyReviewImageHolder() {
    // return InkWell(
    //   onTap: () => ctr.uploadReviewImagePressed(),
    //   child: Container(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Icon(
    //           Icons.image,
    //           color: MyColors.grey4,
    //           size: 100,
    //         ),
    //         Text('submit_review_image'.tr)
    //       ],
    //     ),
    //     height: 150,
    //     width: 500,
    //     decoration: BoxDecoration(
    //         border: Border.all(color: MyColors.desc),
    //         borderRadius:
    //             BorderRadius.all(Radius.circular(MyDimensions.radius))),
    //   ),

    // );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              ctr.uploadReviewImageMultiPressed();
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: MyColors.grey10),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/ico_camera.png',
                    height: 20,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${ctr.urlList.length} / 5',
                    style: MyTextStyles.f12.copyWith(
                        color: MyColors.grey10, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            height: 80,
            child: ListView.builder(
              itemCount: ctr.urlList.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    ctr.urlList.removeAt(index);
                    ctr.pathList.removeAt(index);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Badge(
                      badgeColor: MyColors.primary,
                      badgeContent: Icon(
                        Icons.close,
                        size: 10,
                      ),
                      position: BadgePosition.topEnd(
                        top: 1,
                        end: 1
                      ),
                      child: Container(
                        height: 80,
                        width: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CachedNetworkImage(
                            imageUrl: ctr.urlList[index],
                            width: 80,
                            height: 80,
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Container(
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: downloadProgress.progress,
                                      ),
                                    )),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
          // for (int i = 0; i < ctr.urlList.length; i++) ...[
          //   Text(ctr.urlList[i]),
          // ],
        ],
      ),
    );
  }

  Widget _attachmentPicture() {
    return Obx(
      () => InkWell(
        onTap: () => ctr.uploadReviewImagePressed(),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: ctr.reviewImageUrl.value!,
                width: 500,
                fit: BoxFit.fitWidth,
                // placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _appbar() {
    return CustomAppbar(
        isBackEnable: true,
        title: ctr.selectedReviw!.value.product.title,
        actions: [
          // IconButton(
          //   icon: Icon(
          //     Icons.search,
          //     color: MyColors.black,
          //   ),
          //   onPressed: () {
          //     Get.to(() => SearchPageView());
          //   },
          // ),
          // Obx(
          //   () => ctr2.getNumberProducts() != 0
          //       ? Badge(
          //           badgeColor: MyColors.primary,
          //           badgeContent: Text(
          //             ctr2.getNumberProducts().toString(),
          //             style: TextStyle(
          //                 color: MyColors.black,
          //                 fontSize: 11,
          //                 fontWeight: FontWeight.bold),
          //           ),
          //           toAnimate: false,
          //           position: BadgePosition.topEnd(top: 5, end: 5),
          //           child: IconButton(
          //               onPressed: () {
          //                 Get.to(() => Cart1ShoppingBasketView());
          //               },
          //               icon: Icon(
          //                 Icons.shopping_cart_outlined,
          //                 color: MyColors.black,
          //               )),
          //         )
          //       : IconButton(
          //           onPressed: () {
          //             Get.to(() => Cart1ShoppingBasketView());
          //           },
          //           icon: Icon(
          //             Icons.shopping_cart_outlined,
          //             color: MyColors.black,
          //           ),
          //         ),
          // )
        ]);
  }

  _bottomButtonsBuilder() {
    return MyVars.isUserProject()
        ? isEditing
            // editing review
            ? TwoButtons(
                rightBtnText: '수정',
                leftBtnText: '취소',
                rBtnOnPressed: () => ctr.reviewEditPressed(),
                lBtnOnPressed: () {
                  Get.back();
                  Get.back();
                })
            // new review
            : Container(
                height: Get.height / 17,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
                      onPressed: () {
                        ctr.reviewAddBtnPressed();
                      },
                      child: Text("작성하기",
                          style: MyTextStyles.f16_bold
                              .copyWith(color: MyColors.white))),
                ),
              )
        : SizedBox.shrink();
  }
}
