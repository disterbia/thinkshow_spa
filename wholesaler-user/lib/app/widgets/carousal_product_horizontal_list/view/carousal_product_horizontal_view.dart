import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/Product_detail_view.dart';
import 'package:wholesaler_user/app/widgets/carousal_product_horizontal_list/controller/carousal_product_horizontal_controller.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_vertical_widget.dart';

class CarousalProductHorizontalView extends GetView {
  CarousalProductHorizontalController ctr = Get.put(CarousalProductHorizontalController());
  CarousalProductHorizontalView({required UserHomeTabs currentTab}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctr.init(currentTab);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Obx(
        () => CarouselSlider(
          carouselController: ctr.indicatorSliderController,
          options: CarouselOptions(
              height: 240,
              autoPlay: false,
              viewportFraction: 1 / 3,
              onPageChanged: (index, reason) {
                ctr.sliderIndex.value = index;
              }),
          items: [
            for (Product product in ctr.products)
              GestureDetector(
                onTap: () => Get.to(() => ProductDetailView(), arguments: product.id),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ProductItemVertical(
                    product: product,
                  ),
                ),
              )
          ],
        ),
      ),
      Obx(
        () => _indicator(ctr.products),
      ),
    ]);
  }

  Widget _indicator(List<Product> imgList) {
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
            decoration: BoxDecoration(shape: BoxShape.circle, color: MyColors.primary.withOpacity(ctr.sliderIndex.value == entry.key ? 0.9 : 0.4)),
          ));
        }).toList(),
      ),
    );
  }
}
