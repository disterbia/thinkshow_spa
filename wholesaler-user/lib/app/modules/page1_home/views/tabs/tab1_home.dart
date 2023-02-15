import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/page1_home_controller.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/tab1_user_home_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/Product_detail_view.dart';
import 'package:wholesaler_user/app/widgets/carousal_product_horizontal_list/controller/carousal_product_horizontal_controller.dart';
import 'package:wholesaler_user/app/widgets/carousal_product_horizontal_list/view/carousal_product_horizontal_view.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tags.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tags1.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tags2.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';
import 'package:wholesaler_user/app/widgets/image_slider/controller/image_slider_controller.dart';
import 'package:wholesaler_user/app/widgets/image_slider/view/image_slider_view.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_vertical_widget.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';

class Tab1HomeView extends GetView<Tab1UserHomeController> {
  Tab1UserHomeController ctr = Get.put(Tab1UserHomeController());
  Page1HomeController ctr2 = Get.put(Page1HomeController());

  //  Page1HomeController page1HomeCtr = Get.put(Page1HomeController());
  CarousalProductHorizontalController recommendedProductCtr =
      Get.put(CarousalProductHorizontalController());

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  init() {
    ctr.init();
    //Get.delete<CarousalProductHorizontalController>();
    recommendedProductCtr.init();
  }

  void _onRefresh() async {
    ctr.updateProducts();

    _refreshController.refreshCompleted();
  }

  // void _onLoading() async {
  //   ctr.addDataToList();
  //   _refreshController.loadComplete();
  // }

  @override
  Widget build(BuildContext context) {
    init();
    return Obx(
      () => ctr.isLoading.value && recommendedProductCtr.isLoading.value
          ? LoadingWidget()
          : SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: false,
              onRefresh: _onRefresh,
              // onLoading: _onLoading,
              scrollController: ctr.scrollController.value,
              child: SingleChildScrollView(
                // controller: ctr.scrollController.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ImageSliderView(CurrentPage.homePage),
                    // SizedBox(height: 20),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10),
                    //   child: _dingdongBanner(),
                    // ),
                    // SizedBox(height: 20),
                    recommendedProductCtr.adProducts.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                _recommendedItemsTitle(),
                                CarousalProductHorizontalView(
                                    recommendedProductCtr
                                        .indicatorSliderController1,
                                    0),
                              ],
                            ),
                          )
                        : recommendedProductCtr.exhibitProducts1.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        recommendedProductCtr
                                            .exhibitTitle1.value,
                                        style: MyTextStyles.f16_bold
                                            .copyWith(color: Colors.black),
                                      ),
                                    ),
                                    CarousalProductHorizontalView(
                                        recommendedProductCtr
                                            .indicatorSliderController1,
                                        1),
                                  ],
                                ),
                              )
                            : Container(),
                    Divider(thickness: 5, color: MyColors.grey3),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Obx(() {
                        return HorizontalChipList1().getAllMainCat(
                            categoryList: ClothCategory.getAllMainCat()
                                .map((e) => e.name)
                                .toList(),
                            onTapped: () {
                              ctr.updateProducts();
                            });
                      }),
                    ),
                    ctr.isLoading.value
                        ? Container(height: 200, child: LoadingWidget())
                        : Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: ProductGridViewBuilder(
                                      crossAxisCount: 2,
                                      productHeight: 360,
                                      products: ctr.products1,
                                      isShowLoadingCircle: false.obs
                                      // isShowLoadingCircle: ctr.allowCallAPI,
                                      ),
                                ),
                                recommendedProductCtr
                                        .exhibitProducts2.isNotEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              recommendedProductCtr
                                                  .exhibitTitle2.value,
                                              style: MyTextStyles.f16_bold
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                            CarousalProductHorizontalView(
                                                recommendedProductCtr
                                                    .indicatorSliderController2,
                                                2)
                                          ],
                                        ),
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: ProductGridViewBuilder(
                                      crossAxisCount: 2,
                                      productHeight: 360,
                                      products: ctr.products2,
                                      isShowLoadingCircle: false.obs
                                      // isShowLoadingCircle: ctr.allowCallAPI,
                                      ),
                                ),
                                recommendedProductCtr
                                        .exhibitProducts3.isNotEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              recommendedProductCtr
                                                  .exhibitTitle3.value,
                                              style: MyTextStyles.f16_bold
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                            CarousalProductHorizontalView(
                                                recommendedProductCtr
                                                    .indicatorSliderController3,
                                                3)
                                          ],
                                        ),
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: ProductGridViewBuilder(
                                      crossAxisCount: 2,
                                      productHeight: 360,
                                      products: ctr.products3,
                                      isShowLoadingCircle: false.obs
                                      // isShowLoadingCircle: ctr.allowCallAPI,
                                      ),
                                ),
                                recommendedProductCtr.beltImage.value != ""
                                    ? Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          height: 120,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                                imageUrl: recommendedProductCtr
                                                    .beltImage.value,
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: ProductGridViewBuilder(
                                      crossAxisCount: 2,
                                      productHeight: 360,
                                      products: ctr.products4,
                                      isShowLoadingCircle: false.obs
                                      // isShowLoadingCircle: ctr.allowCallAPI,
                                      ),
                                ),
                                recommendedProductCtr
                                        .exhibitProducts4.isNotEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              recommendedProductCtr
                                                  .exhibitTitle4.value,
                                              style: MyTextStyles.f16_bold
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                            CarousalProductHorizontalView(
                                                recommendedProductCtr
                                                    .indicatorSliderController4,
                                                4)
                                          ],
                                        ),
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: ProductGridViewBuilder(
                                      crossAxisCount: 2,
                                      productHeight: 360,
                                      products: ctr.products5,
                                      isShowLoadingCircle: false.obs
                                      // isShowLoadingCircle: ctr.allowCallAPI,
                                      ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
    );
  }

  // Widget _dingdongBanner() {
  //   return GestureDetector(
  //     onTap: () {
  //       print('dingdong_delivery_banner tap detected. ');
  //       page1HomeCtr.tabBarIndex.value = UserHomeTabs.dingdong.index;
  //       print('page1HomeCtr.tabBarIndex.value ${page1HomeCtr.tabBarIndex.value}');
  //     },
  //     child: Container(
  //       child: Image.asset(
  //         'assets/images/dingdong_delivery_banner.png',
  //       ),
  //     ),
  //   );
  // }
  // Widget carouselSlide(List<Product> products,RxInt current){
  //   return
  //     Obx(
  //         ()=> CarouselSlider(
  //           carouselController: recommendedProductCtr.indicatorSliderController1,
  //         items: [
  //           for (Product product in products)
  //             GestureDetector(
  //               onTap: () => Get.to(() => ProductDetailView(), arguments: product.id),
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 5),
  //                 child: ProductItemVertical(
  //                   product: product,
  //                   isBig: true,
  //                 ),
  //               ),
  //             )
  //         ],
  //           options: CarouselOptions(
  //             pageSnapping: true,
  //             height: 240,
  //             viewportFraction: 1,
  //             scrollDirection: Axis.horizontal,
  //             onPageChanged: (index, reason) {
  //               recommendedProductCtr.sliderIndex1.value=index;
  //             },
  //           )),
  //     );
  // }

  Widget _recommendedItemsTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'recommended_item'.tr,
            style: MyTextStyles.f16,
          ),
          Text(
            'Sponsored',
            style: MyTextStyles.f14.copyWith(color: MyColors.black1),
          )
        ],
      ),
    );
  }
}
