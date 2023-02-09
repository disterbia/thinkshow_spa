import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/page1_home_controller.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/tab1_user_home_controller.dart';
import 'package:wholesaler_user/app/widgets/carousal_product_horizontal_list/controller/carousal_product_horizontal_controller.dart';
import 'package:wholesaler_user/app/widgets/carousal_product_horizontal_list/view/carousal_product_horizontal_view.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tags.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';
import 'package:wholesaler_user/app/widgets/image_slider/controller/image_slider_controller.dart';
import 'package:wholesaler_user/app/widgets/image_slider/view/image_slider_view.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';

class Tab1HomeView extends GetView<Tab1UserHomeController> {
  Tab1UserHomeController ctr = Get.put(Tab1UserHomeController());

  //  Page1HomeController page1HomeCtr = Get.put(Page1HomeController());
  CarousalProductHorizontalController recommendedProductCtr =
      Get.put(CarousalProductHorizontalController());

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  RxInt current1=0.obs;
  RxInt current2=0.obs;
  RxInt current3=0.obs;
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
                    recommendedProductCtr.products.length != 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                _recommendedItemsTitle(),
                                //CarousalProductHorizontalView(),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "관리자가 설정한 기획전 제목",
                                    style: MyTextStyles.f16_bold
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                CarousalProductHorizontalView(),
                              ],
                            ),
                          ),
                    Divider(thickness: 5, color: MyColors.grey3),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Obx(
                        () => HorizontalChipList().getAllMainCat(
                            categoryList: ClothCategory.getAllMainCat()
                                .map((e) => e.name)
                                .toList(),
                            onTapped: () {
                              ctr.updateProducts();
                            }),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      //api 여러번 호출하는거 밖에 방법이 없다.
                      child: ProductGridViewBuilder(
                          crossAxisCount: 2,
                          productHeight: 360,
                          products: ctr.products,
                          isShowLoadingCircle: false.obs
                          // isShowLoadingCircle: ctr.allowCallAPI,
                          ),
                    ),
                    carouselSlide(),
                    dotIndicator(current1.value),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 15),
                    //   child: ProductGridViewBuilder(
                    //       isHome: true,
                    //       count: 8,
                    //       productIndex: 6,
                    //       crossAxisCount: 2,
                    //       productHeight: 360,
                    //       products: ctr.products,
                    //       isShowLoadingCircle: false.obs
                    //     // isShowLoadingCircle: ctr.allowCallAPI,
                    //   ),
                    // ),
                    // carouselSlide(),
                    // dotIndicator(),
                    // Container(color: Colors.red,height: 100,),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 15),
                    //   child: ProductGridViewBuilder(
                    //       isHome: true,
                    //       count: 4,
                    //       productIndex: 14,
                    //       crossAxisCount: 2,
                    //       productHeight: 360,
                    //       products: ctr.products,
                    //       isShowLoadingCircle: false.obs
                    //     // isShowLoadingCircle: ctr.allowCallAPI,
                    //   ),
                    // ),
                    // carouselSlide(),
                    // dotIndicator(),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 15),
                    //   child: ProductGridViewBuilder(
                    //       isHome: true,
                    //       count: 12,
                    //       productIndex: 18,
                    //       crossAxisCount: 2,
                    //       productHeight: 360,
                    //       products: ctr.products,
                    //       isShowLoadingCircle: false.obs
                    //     // isShowLoadingCircle: ctr.allowCallAPI,
                    //   ),
                    // ),
                    // carouselSlide(),
                    // dotIndicator(),
                    // Padding(
                    //   padding:const EdgeInsets.symmetric(horizontal: 15),
                    //   child: ProductGridViewBuilder(
                    //       isHome: true,
                    //       count: ctr.products.length-30,
                    //       productIndex: 30,
                    //       crossAxisCount: 2,
                    //       productHeight: 360,
                    //       products: ctr.products,
                    //       isShowLoadingCircle: false.obs
                    //     // isShowLoadingCircle: ctr.allowCallAPI,
                    //   ),
                    // ),


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
  Widget carouselSlide(){
    return
      CarouselSlider(
          items: carouselRow(),
          options: CarouselOptions(
            height: 100,
            viewportFraction: 1,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              current1.value=index;
            },
          ));
  }
  Widget dotIndicator(int current){
    return    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      for (var i = 0; i < 5; i++)
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: current == i
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4)),
        ),
    ]);
  }
  List<Widget> carouselRow() {
    return [
      Row(
        children: [
          Container(
            height: 100,
            width: Get.width / 4,
            color: Colors.red,
          ),
          Container(
            height: 100,
            width: Get.width / 4,
            color: Colors.blue,
          ),
          Container(
            height: 100,
            width: Get.width / 4,
            color: Colors.red,
          ),
        ],
      ),
      Row(
        children: [
          Container(
            height: 100,
            width: Get.width / 4,
            color: Colors.red,
          ),
          Container(
            height: 100,
            width: Get.width / 4,
            color: Colors.blue,
          ),
          Container(
            height: 100,
            width: Get.width / 4,
            color: Colors.red,
          ),
        ],
      ),
      Row(
        children: [
          Container(
            height: 100,
            width: Get.width / 4,
            color: Colors.red,
          ),
          Container(
            height: 100,
            width: Get.width / 4,
            color: Colors.blue,
          ),
          Container(
            height: 100,
            width: Get.width / 4,
            color: Colors.red,
          ),
        ],
      ),
      Row(
        children: [
          Container(
            height: 100,
            width: Get.width / 4,
            color: Colors.red,
          ),
          Container(
            height: 100,
            width: Get.width / 4,
            color: Colors.blue,
          ),
          Container(
            height: 100,
            width: Get.width / 4,
            color: Colors.red,
          ),
        ],
      ),
      Row(
        children: [
          Container(
            height: 100,
            width: Get.width / 4,
            color: Colors.red,
          ),
          Container(
            height: 100,
            width: Get.width / 4,
            color: Colors.blue,
          ),
          Container(
            height: 100,
            width: Get.width / 4,
            color: Colors.red,
          ),
        ],
      ),
    ];
  }

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
