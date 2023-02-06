import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/models/review.dart';
import 'package:wholesaler_user/app/models/review_category.dart';
import 'package:wholesaler_user/app/models/review_mdoel2.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/views/review_detail_view2.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/tab_2_review_controller.dart';
import 'package:wholesaler_user/app/modules/review_detail/views/review_detail_view.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_horiz_widget.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class Tab2ReviewView extends GetView {
  Tab2ReviewProductDetailController ctr =
      Get.put(Tab2ReviewProductDetailController());
  ProductDetailController productDetailCtr = Get.put(ProductDetailController());

  Tab2ReviewView();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // if (ctr.reviews.isNotEmpty &&
              //     ctr.reviews.first.writableReviewInfoModel!.is_writable!)
              //   _addReviewButton(),

              SizedBox(
                height: 20,
              ),

              ctr.reviewInfoModel.value.avg_star != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _mainRateBar(ctr.reviewInfoModel.value.avg_star!),
                        SizedBox(
                          width: 5,
                        ),
                        Text(ctr.reviewInfoModel.value.avg_star!.toString(),
                            style: MyTextStyles.f16_bold.copyWith(
                                fontWeight: FontWeight.bold,
                                color: MyColors.black2))
                      ],
                    )
                  : SizedBox.shrink(),
              SizedBox(
                height: 20,
              ),

              ctr.reviewInfoModel.value.review_total_count != 0 &&
                      ctr.reviewInfoModel.value.review_total_count != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '리뷰 ${Utils.numberFormat(number: ctr.reviewInfoModel.value.review_total_count!)}개',
                            style: MyTextStyles.f16_bold
                                .copyWith(color: MyColors.black2),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  '전체보기',
                                  style: MyTextStyles.f14
                                      .copyWith(color: MyColors.black2),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset('assets/icons/ico_arrow01.png',
                                    height: 15),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(
                height: 20,
              ),
              ctr.reviewInfoModel.value.reviewCategoryModel!['fit_info'] != null
                  ? _progressWidget(
                      '착용감',
                      ctr.reviewInfoModel.value
                          .reviewCategoryModel!['fit_info']!)
                  : SizedBox.shrink(),

              SizedBox(
                height: 10,
              ),
              ctr.reviewInfoModel.value.reviewCategoryModel!['color_info'] !=
                      null
                  ? _progressWidget(
                      '색감',
                      ctr.reviewInfoModel.value
                          .reviewCategoryModel!['color_info']!)
                  : SizedBox.shrink(),

              SizedBox(
                height: 10,
              ),
              ctr.reviewInfoModel.value.reviewCategoryModel!['quality_info'] !=
                      null
                  ? _progressWidget(
                      '퀄리티',
                      ctr.reviewInfoModel.value
                          .reviewCategoryModel!['quality_info']!)
                  : SizedBox.shrink(),
              SizedBox(
                height: 20,
              ),
              //포토리뷰 자리
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(
                  color: MyColors.grey3,
                ),
              ),
              for (int i = 0; i < ctr.reviews.length; i++) ...[
                Column(
                  children: [
                    _reviewItemBuilder(ctr.reviews[i], i),
                    Divider(
                      thickness: 5,
                      color: MyColors.grey3,
                    ),
                  ],
                ),
              ],
              if (ctr.reviews.isEmpty) SizedBox.shrink(),
              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child: Center(child: Text('아직 등록된 리뷰가 없습니다')),
              // ),

              SizedBox(
                height: 20,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _progressWidget(
      String title, ReviewCategoryModel reviewCategoryModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: MyTextStyles.f14.copyWith(color: MyColors.grey10),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              reviewCategoryModel.name!,
              style: MyTextStyles.f14.copyWith(color: MyColors.black2),
            ),
          ),
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                minHeight: 8,
                value: reviewCategoryModel.percent! / 100.0,
              ),
            ),
          ),
          // SizedBox(
          //   width: 15,
          // ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                reviewCategoryModel.percent!.toString() + "%",
                style: MyTextStyles.f14.copyWith(color: MyColors.grey10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _addReviewButton() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: OutlinedButton(
  //       onPressed: (() {
  //         if (CacheProvider().getToken().isEmpty) {
  //           Get.to(() => User_LoginPageView());
  //           return;
  //         }
  //         Get.to(() => ReviewDetailView(
  //               isComingFromReviewPage: true,
  //               isEditing: false,
  //               selectedReviw: Review(
  //                   id: -1,
  //                   content: '',
  //                   rating: 0,
  //                   ratingType: ProductRatingType.star,
  //                   date: DateTime.now(),
  //                   createdAt: Utils.dateToString(date: DateTime.now()),
  //                   product: ctr.reviews.first.product,
  //                   reviewImageUrl: '',
  //                   writableReviewInfoModel:
  //                       ctr.reviews.first.writableReviewInfoModel),
  //             ));
  //       }),
  //       child: Text(
  //         '리뷰 작성',
  //         style: MyTextStyles.f14.copyWith(color: MyColors.black1),
  //       ),
  //     ),
  //   );
  // }

  Widget _reviewItemBuilder(Review review, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          // Divider(thickness: 1, color: MyColors.grey1),
          _header(review),
          SizedBox(
            height: 10,
          ),
          // ProductItemHorizontal(product: review.product),
          // SizedBox(height: 5),
          // _rate(review),
          // _comment(review),
          // if (review.images != null)
          //   for (String imageUrl in review.images!) _imageBuilder(imageUrl),
          // review.reviewImageUrl != null
          //     ? CachedNetworkImage(
          //         imageUrl: review.reviewImageUrl!,
          //         fit: BoxFit.contain,
          //         // placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          //         errorWidget: (context, url, error) => Icon(Icons.error),
          //       )
          //     : SizedBox.shrink(),
          // ReviewDetailView2(review: reviewModel2),
          SizedBox(
            height: 15,
          ),
          review.images != null
              ? Column(
                  children: [
                    imagesSlider(review, index),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                )
              : SizedBox.shrink(),

          categoryWidget(review),
          SizedBox(
            height: 15,
          ),
          contentWidget(review),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget contentWidget(Review review) {
    return Text(
      review.content,
      style: MyTextStyles.f14.copyWith(color: MyColors.black2),
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget imagesSlider(Review review, int index) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CarouselSlider(
          carouselController: ctr.indicatorSliderController[index],
          options: CarouselOptions(
              height: Get.height * 0.5,
              autoPlay: false,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                ctr.sliderIndex[index] = index;
              }),
          items: [
            for (String img in review.images!)
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  width: Get.width,
                  imageUrl: img,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              )
          ],
        ),
        Positioned(
          bottom: 20,
          child: Obx(
            () => _indicator(review.images!),
          ),
        ),
      ],
    );
  }

  Widget _indicator(List<String> imgList) {
    print('inisde _indicator imgList ${imgList.length}');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: imgList.asMap().entries.map((entry) {
          return GestureDetector(
              // onTap: () => ctr.indicatorSliderController.animateToPage(entry.key),
              child: Container(
            width: 10.0,
            height: 10.0,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.primary.withOpacity(
                    ctr.sliderIndex.value == entry.key ? 0.9 : 0.4)),
          ));
        }).toList(),
      ),
    );
  }

  Widget categoryWidget(Review review) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '만족도',
                style: MyTextStyles.f14.copyWith(color: MyColors.grey10),
              ),
            ),
            Expanded(
              flex: 4,
              child: _rateBar(review),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '선택옵션',
                style: MyTextStyles.f14.copyWith(color: MyColors.grey10),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                review.product.OLD_option!,
                style: MyTextStyles.f14.copyWith(
                    color: MyColors.grey10, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '착용감',
                style: MyTextStyles.f14.copyWith(color: MyColors.grey10),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                review.category_fit_name!,
                style: MyTextStyles.f14.copyWith(
                    color: MyColors.grey10, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '색감',
                style: MyTextStyles.f14.copyWith(color: MyColors.grey10),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                review.category_color_name!,
                style: MyTextStyles.f14.copyWith(
                    color: MyColors.grey10, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '퀄리티',
                style: MyTextStyles.f14.copyWith(color: MyColors.grey10),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                review.category_quality_name!,
                style: MyTextStyles.f14.copyWith(
                    color: MyColors.grey10, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _mainRateBar(double rating) {
    return RatingBar.builder(
      ignoreGestures: true, // disable gesture to rate
      initialRating: rating,
      direction: Axis.horizontal,
      itemSize: 25,
      itemCount: 5,

      itemBuilder: (context, _) => Icon(
        Icons.star_rounded,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }

  Widget _rateBar(Review review) {
    return RatingBar.builder(
      ignoreGestures: true, // disable gesture to rate
      initialRating: review.rating.toDouble(),
      direction: Axis.horizontal,
      itemSize: 20,
      itemCount: 5,

      itemBuilder: (context, _) => Icon(
        Icons.star_rounded,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }

  Widget _header(Review review) {
    return Row(
      children: [
        Text(
          review.user != null ? review.user!.userName : 'null',
          style: MyTextStyles.f14.copyWith(color: MyColors.grey2),
        ),
        SizedBox(width: 10),
        SizedBox(
          height: 20,
          child: VerticalDivider(
            thickness: 1,
            color: MyColors.grey11,
          ),
        ),
        SizedBox(width: 10),
        Text(
          DateFormat('yyyy.MM.dd').format(review.date),
          style: MyTextStyles.f14.copyWith(color: MyColors.grey2),
        ),
        // Spacer(),
        // ReportEditDeleteButtons(review),
      ],
    );
  }

  Widget _rate(Review review) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: MyColors.primary,
        ),
        Text(review.rating.toString())
      ],
    );
  }

  Widget _comment(Review review) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(review.content),
    );
  }

  Widget _imageBuilder(String imageUrl) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 100,
          height: 150,
          fit: BoxFit.cover,
          // placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  ReportEditDeleteButtons(Review review) {
    if (review.isMine != null && review.isMine!) {
      // my review. Show 수정, 삭제 button
      return Row(
        children: [
          CustomButton(
            width: 50,
            backgroundColor: MyColors.grey1,
            borderColor: Colors.transparent,
            text: '수정',
            fontSize: 12,
            textColor: MyColors.black2,
            onPressed: () {
              Get.to(() => ReviewDetailView(
                    isComingFromReviewPage: true,
                    isEditing: true,
                    selectedReviw: review,
                  ));
            },
          ),
          SizedBox(width: 10),
          CustomButton(
            width: 50,
            backgroundColor: MyColors.grey1,
            borderColor: Colors.transparent,
            text: '삭제',
            fontSize: 12,
            textColor: MyColors.black2,
            onPressed: () => ctr.deleteReviewPressed(review),
          ),
        ],
      );
    } else {
      // Not my review. Show 신고하기 button
      // return TextButton(
      //   onPressed: () => mSnackbar(message: '신고 되었습니다.'),
      //   child: Text(
      //     '신고하기',
      //     style: MyTextStyles.f12.copyWith(color: MyColors.grey2),
      //   ),
      // );
      return SizedBox.shrink();
    }
  }
}
