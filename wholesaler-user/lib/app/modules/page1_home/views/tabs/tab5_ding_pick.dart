import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/page1_home_controller.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/tab5_ding_pick_controller.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';

class Tab5DingPickView extends GetView<Tab5DingPickController> {
  Tab5DingPickController ctr = Get.put(Tab5DingPickController());
  Page1HomeController ctr2 = Get.put(Page1HomeController());
  Tab5DingPickView();

  init() {
    ctr.init();
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        ProductGridViewBuilder(
                          crossAxisCount: 3,
                          productHeight: (500*0.7).floor(),
                          products: ctr.products,
                          isShowLoadingCircle: ctr.allowCallAPI,
                        ),
                      ],
                    ),
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
