// ignore_for_file: must_be_immutable
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/modules/cart/views/cart1_shopping_basket_view.dart';
import 'package:wholesaler_user/app/modules/page3_product_category_page/controller/product_category_page_controller.dart';
import 'package:wholesaler_user/app/modules/search/views/search_page_view.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tags.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';

import '../../cart/controllers/cart1_shopping_basket_controller.dart';

class ProductCategoryPageView extends GetView<ProductCategoryPageController> {
  ProductCategoryPageController ctr = Get.put(ProductCategoryPageController());
  Cart1ShoppingBasketController ctr2 = Get.put(Cart1ShoppingBasketController());

  int index;
  ProductCategoryPageView(this.index) {
    HorizontalChipList().ctr.selectedMainCatIndex.value = 0;
    // ctr.selectedMainCatIndex = selectedMainCatIndex;
  }

  init() async {
    await ctr.init(index);
    ctr2.init();
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: _appbar(),
      body: _body(),
    );
  }

  AppBar _appbar() {
    return CustomAppbar(isBackEnable: true, title: ctr.title, actions: [
      IconButton(
        icon: Icon(
          Icons.search,
          color: MyColors.black,
        ),
        onPressed: () {
          Get.to(() => SearchPageView());
        },
      ),
      Obx(
        () => ctr2.getNumberProducts() != 0
            ? Badge(
                badgeColor: MyColors.primary,
                badgeContent: Text(
                  ctr2.getNumberProducts().toString(),
                  style: TextStyle(
                      color: MyColors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
                toAnimate: false,
                position: BadgePosition.topEnd(top: 5, end: 5),
                child: IconButton(
                  onPressed: () {
                    Get.to(() => Cart1ShoppingBasketView());
                  },
                  icon: ImageIcon(
                    AssetImage('assets/icons/top_cart.png'),
                    size: 21,
                    // Icons.shopping_cart_outlined,
                    color: MyColors.black,
                  ),
                ),
              )
            : IconButton(
                onPressed: () {
                  Get.to(() => Cart1ShoppingBasketView());
                },
                icon: ImageIcon(
                  AssetImage('assets/icons/top_cart.png'),
                  size: 21,
                  // Icons.shopping_cart_outlined,
                  color: MyColors.black,
                ),
              ),
      )
    ]);
  }

  Widget _body() {
    return Obx(
      () => ctr.isLoading.value
          ? LoadingWidget()
          : SingleChildScrollView(
              controller: ctr.scrollController.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: HorizontalChipList().getAllSubcat(
                      parentId: index + 1,
                      subCatList: ClothCategory.getAllSubcatTitles(
                          mainCatIndex: index + 1),
                      onTapped: (selectedSubcat) =>
                          ctr.subCatChipPressed(selectedSubcat),
                    ),
                  ),
                  SizedBox(height: 5),
                  dropdownBuilder(),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ProductGridViewBuilder(
                      crossAxisCount: 3,
                      productHeight: (500*0.7).floor(),
                      products: ctr.products,
                      isShowLoadingCircle: ctr.allowCallAPI,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget dropdownBuilder() {
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
                // print('$newValue');
                ctr.selectedDropdownIndex.value =
                    ctr.dropdownItems.indexOf(newValue!);
                ctr.updateProducts(isScrolling: false);
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
