import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/review.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_review_list_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/tab_3_inquiry_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/product_inquiry_view.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

class ProductReviewListView extends GetView {
  ProductReviewListController ctr = Get.put(ProductReviewListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          isBackEnable: true, title: Get.arguments['isPhoto'] ? '포토리뷰' : '리뷰'),
      body: Obx(
        () => SingleChildScrollView(
          controller: ctr.scrollController.value,
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: ctr.reviews.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  _reviewItemBuilder(ctr.reviews[index], index),
                  Divider(
                    thickness: 5,
                    color: MyColors.grey3,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _reviewItemBuilder(Review review, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          _header(review),
          SizedBox(
            height: 10,
          ),
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
                child: ExtendedImage.network(clearMemoryCacheWhenDispose:true,enableMemoryCache:false,enableLoadState: false,cacheWidth: 1024,cacheHeight: 1365,
                  fit: BoxFit.fill,
                  width: GetPlatform.isMobile?Get.width:500,
                   img,
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
}
