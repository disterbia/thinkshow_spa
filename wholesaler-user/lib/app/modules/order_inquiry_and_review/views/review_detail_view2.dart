import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/review.dart';
import 'package:wholesaler_user/app/models/review_mdoel2.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/controllers/review_controller.dart';
import 'package:wholesaler_user/app/modules/review_detail/views/review_detail_view.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';

class ReviewDetailView2 extends GetView {
  CarouselController indicatorSliderController = CarouselController();
  int sliderIndex = 0;
  ReviewModel2 review;
  late List<String> images;
  ReviewDetailView2({required this.review}) {
    this.images = review.product_info!.imgUrl.split(',');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppbar(title: '리뷰', isBackEnable: true, hasHomeButton: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            pruductWidget(review.product_info!),
            Divider(
              color: MyColors.grey1,
            ),
            imagesSlider(),
          ],
        ),
      ),
    );
  }

  Widget imagesSlider() {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CarouselSlider(
          carouselController: indicatorSliderController,
          options: CarouselOptions(
              height: Get.height * 0.5,
              autoPlay: false,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                sliderIndex = index;
              }),
          items: [
            for (String img in images)
              CachedNetworkImage(
                fit: BoxFit.fill,
                width: Get.width,
                imageUrl: img,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
          ],
        ),
        Positioned(
          bottom: 20,
          child: Obx(
            () => _indicator(images),
          ),
        ),
      ],
    );
  }

  Widget _indicator(List<String> imgList) {
    print('inisde _indicator imgList $imgList');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                color: MyColors.primary
                    .withOpacity(sliderIndex == entry.key ? 0.9 : 0.4)),
          ));
        }).toList(),
      ),
    );
  }

  Widget pruductWidget(Product product) {
    return Container(
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
                          color: MyColors.black3, fontWeight: FontWeight.w400),
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
    );
  }
}
