// ignore_for_file: must_be_immutable

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart1_shopping_basket_controller.dart';
import 'package:wholesaler_user/app/modules/cart/views/cart1_shopping_basket_view.dart';
import 'package:wholesaler_user/app/modules/page4_favorite_products/controllers/page4_favorite_products_controller.dart';
import 'package:wholesaler_user/app/modules/search/views/search_page_view.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';

/// [Page4FavoriteProductsView] is same view for both 찜 페이지 and 최근 본상품
class Page4FavoriteProductsView extends GetView {
  Page4Favorite_RecentlyViewedController ctr =
      Get.put(Page4Favorite_RecentlyViewedController());
  Cart1ShoppingBasketController ctr2 = Get.put(Cart1ShoppingBasketController());

  Page4FavoriteProductsView({required bool isRecentSeenProduct}) {
    ctr.isRecentSeenProduct = isRecentSeenProduct;
  }

  onInit() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    ctr.updateProducts();
    ctr2.init();
    // });
  }

  @override
  Widget build(BuildContext context) {
    onInit();
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: _appbar(),
      body: Obx(() => ctr.isLoading.value ? LoadingWidget() : _body()),
    );
  }

  Widget _body() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _title(),
                ProductGridViewBuilder(
                  crossAxisCount: 3,
                  productHeight: (500*0.7).floor(),
                  products: ctr.products,
                  isShowLoadingCircle: false.obs,
                ),
              ],
            ),
          ),
        ),
      );

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          ctr.isRecentSeenProduct ? '최근 본 상품' : 'favorite_products'.tr,
          style: MyTextStyles.f16.copyWith(color: MyColors.black2),
        ),
      ),
    );
  }

  AppBar _appbar() {
    return CustomAppbar(
        isBackEnable: ctr.isRecentSeenProduct,
        title: ctr.isRecentSeenProduct ? '최근 본 상품' : 'favorite_products'.tr,
        actions: [
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
                          color: MyColors.black,
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
}
