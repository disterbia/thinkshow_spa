import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/models/product_number_model.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/page1_home_controller.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/tab2_best_controller.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tags.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tags2.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';

class Tab2BestView extends GetView<Tab2BestController> {
  Tab2BestController ctr = Get.put(Tab2BestController());
  Page1HomeController ctr2 = Get.put(Page1HomeController());
  Tab2BestView();

  init() {
    HorizontalChipList2().ctr.selectedMainCatIndex.value = 0;
    ctr.updateProducts();
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Obx(
      () => Stack(
        children: [
          SingleChildScrollView(
            controller: ctr.scrollController.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: HorizontalChipList2().getAllMainCat(
                        categoryList: ClothCategory.getAllMainCat()
                            .map((e) => e.name)
                            .toList(),
                        onTapped: () {
                          ctr.updateProducts();
                        })),
                SizedBox(height: 5),
                _button(),
                SizedBox(height: 10),
                ctr.isLoading.value
                    ? LoadingWidget()
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ProductGridViewBuilder(
                              crossAxisCount: 2,
                              productHeight:(500*0.8).floor(),
                              products: ctr.products,
                              isShowLoadingCircle: ctr.allowCallAPI,
                            ),
                          ),
                        ],
                      )
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

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(
            () => DropdownButton(
              hint: Text(ctr.dropdownItems[ctr.selectedDropdownIndex.value]),
              items: itemsBuilder(ctr.dropdownItems),
              onChanged: (String? newValue) {
                log('$newValue');
                ctr.selectedDropdownIndex.value =
                    ctr.dropdownItems.indexOf(newValue!);
                ctr.updateProducts();
              },
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> itemsBuilder(List<String> itemStrings) {
    return itemStrings.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
