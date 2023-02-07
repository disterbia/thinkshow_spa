import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/review.dart';
import 'package:wholesaler_user/app/models/review_mdoel2.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/controllers/review_controller.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/controllers/review_detail_controller2.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/Product_detail_view.dart';
import 'package:wholesaler_user/app/modules/review_detail/views/review_detail_view.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';

class ReviewDetailView2 extends GetView {
  ReviewDetailController2 ctr = Get.put(ReviewDetailController2());

  ReviewModel2 review;
  ReviewDetailView2({required this.review});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppbar(title: '리뷰', isBackEnable: true, hasHomeButton: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pruductWidget(review.product_info!),
            Divider(
              color: MyColors.grey1,
            ),
            review.image_file_path != null ? imagesSlider() : SizedBox.shrink(),
            categoryWidget(),
            contentWidget(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget contentWidget() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Text(
        review.content!,
        style: MyTextStyles.f14.copyWith(color: MyColors.black2),
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget categoryWidget() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
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
                child: _rateBar(),
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
                  review.select_option_name!,
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
      ),
    );
  }

  Widget _rateBar() {
    return RatingBar.builder(
      ignoreGestures: true, // disable gesture to rate
      initialRating: review.star!.toDouble(),
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

  Widget imagesSlider() {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CarouselSlider(
          carouselController: ctr.indicatorSliderController,
          options: CarouselOptions(
              height: Get.height * 0.5,
              autoPlay: false,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                ctr.sliderIndex.value = index;
              }),
          items: [
            for (String img in review.image_file_path!)
              Padding(
                padding: EdgeInsets.all(15.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    width: Get.width,
                    imageUrl: img,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              )
          ],
        ),
        Positioned(
          bottom: 20,
          child: Obx(
            () => _indicator(review.image_file_path!),
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

  Widget pruductWidget(Product product) {
    return InkWell(
      onTap: () {
        //
        if (MyVars.isUserProject()) {
          Get.to(() => ProductDetailView(), arguments: product.id);
        }
      },
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl: product.imgUrl,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        product.title,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: MyTextStyles.f16.copyWith(
                            color: MyColors.black3,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            Image.asset(
              'assets/icons/ico_etc.png',
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
