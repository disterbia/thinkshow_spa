import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/page1_home_controller.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/tab4_ding_dong_controller.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tags.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tags3.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';
import 'package:wholesaler_user/app/widgets/image_slider/controller/image_slider_controller.dart';
import 'package:wholesaler_user/app/widgets/image_slider/view/image_slider_view.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';

class Tab4DingDongView extends GetView<Tab4DingDongController> {
  Tab4DingDongController ctr = Get.put(Tab4DingDongController());
  Page1HomeController ctr2 = Get.put(Page1HomeController());
  Tab4DingDongView();

  init() {
    ctr.init();
    HorizontalChipList3().ctr.selectedMainCatIndex.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Obx(
      () => ctr.isLoading.value
          ? LoadingWidget()
          : Stack(
              children: [
                SingleChildScrollView(
                  controller: ctr.scrollController.value,
                  child: Column(
                    children: [
                      ImageSliderView(CurrentPage.dingDongPage),
                      SizedBox(height: 10),
                      Obx(() => Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: HorizontalChipList3().getAllMainCat(
                              categoryList: ClothCategory.getAllMainCat()
                                  .map((e) => e.name)
                                  .toList(),
                              onTapped: () => ctr.updateProducts(),
                            ),
                          )),
                      SizedBox(height: 10),
                      Obx(
                        () => ctr.products.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(20),
                                child: Center(child: Text('상품 준비중입니다')),
                              )
                            : SizedBox(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ProductGridViewBuilder(
                          crossAxisCount: 3,
                          productHeight: (500*0.7).floor(),
                          products: ctr.products,
                          // products: <Product>[].obs,
                          isShowLoadingCircle: ctr.allowCallAPI,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: SizedBox(
                    width: 45,
                    height: 45,
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_upward_rounded),
                      onPressed: () {
                        ctr.scrollController.value.jumpTo(0);
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
