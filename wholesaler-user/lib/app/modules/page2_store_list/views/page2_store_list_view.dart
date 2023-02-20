import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart1_shopping_basket_controller.dart';
import 'package:wholesaler_user/app/modules/cart/views/cart1_shopping_basket_view.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/page1_home_controller.dart';
import 'package:wholesaler_user/app/modules/page2_store_list/controllers/shopping_controller.dart';
import 'package:wholesaler_user/app/modules/page2_store_list/controllers/shopping_controller2.dart';
import 'package:wholesaler_user/app/modules/page2_store_list/views/tabs/tab1_ranking_view.dart';
import 'package:wholesaler_user/app/modules/page2_store_list/views/tabs/tab2_bookmarks.dart';
import 'package:wholesaler_user/app/modules/search/views/search_page_view.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/main_appbar.dart';
import 'package:wholesaler_user/app/widgets/simple_tab_bar.dart';

class Page2StoreListView extends GetView {
  Cart1ShoppingBasketController ctr2 = Get.put(Cart1ShoppingBasketController());
  Page2StoreListController ctr = Get.put(Page2StoreListController());
  Page2StoreListController2 ctr3 = Get.put(Page2StoreListController2());
  Page1HomeController ctr4 = Get.put(Page1HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: _mainAppbar(),
      body: _body(),
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: Colors.white,
      //     child: Icon(Icons.arrow_upward_rounded),
      //     onPressed: () {
      //       if(ctr4.storeIndex.value==0){
      //         ctr.scrollController.jumpTo(0);
      //       }else
      //       ctr3.scrollController.jumpTo(0);
      //     }),
    );
  }

  AppBar _mainAppbar() {
    return MainAppbar(
      isBackEnable: false,
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
      ],
    );
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
          child: SimpleTabBar(
            borderColor: MyColors.white,
            initialIndex: 0,
            tabs: [
              Tab(
                text: 'ranking'.tr,
              ),
              Tab(
                text: 'Favorites'.tr,
              )
            ],
            tabBarViews: [
              Tab1RankingView(),
              Tab2BookmarksView(),
            ],
          ),
        ),
      ],
    );
  }
}