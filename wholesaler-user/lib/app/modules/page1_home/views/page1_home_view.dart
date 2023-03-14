import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/enum.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart1_shopping_basket_controller.dart';
import 'package:wholesaler_user/app/modules/cart/views/cart1_shopping_basket_view.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/page1_home_controller.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/tab1_user_home_controller.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/tab2_best_controller.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/tab3_new_products_controller.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/tab4_ding_dong_controller.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/tab5_ding_pick_controller.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/tabs/tab1_home.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/tabs/tab2_best.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/tabs/tab3_new_products.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/tabs/tab4_ding_dong.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/tabs/tab5_ding_pick.dart';
import 'package:wholesaler_user/app/modules/search/views/search_page_view.dart';
import 'package:wholesaler_user/app/widgets/main_appbar.dart';
import 'package:wholesaler_user/app/widgets/simple_tab_bar.dart';

class Page1HomeView extends GetView<Page1HomeController> {
  Page1HomeController ctr = Get.put(Page1HomeController());
  Cart1ShoppingBasketController cartCtr =
      Get.put(Cart1ShoppingBasketController());
  // Tab1UserHomeController ctr0 = Get.put(Tab1UserHomeController());
  // Tab2BestController ctr1 = Get.put(Tab2BestController());
  // Tab3NewProductsController ctr2 = Get.put(Tab3NewProductsController());
  // Tab4DingDongController ctr3 = Get.put(Tab4DingDongController());
  // Tab5DingPickController ctr4 = Get.put(Tab5DingPickController());

  Page1HomeView();

  init() {
    cartCtr.init();
  }

  @override
  Widget build(BuildContext context) {
    init();
    // print(ctr2.getNumberProducts());
    return Scaffold(
      appBar: _mainAppbar(),
      backgroundColor: MyColors.white,
      body: _floatTabBar(),
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: Colors.white,
      //     child: Icon(Icons.arrow_upward_rounded),
      //     onPressed: () {
      //       int index = ctr.tabBarIndex.value;

      //       switch (index) {
      //         case 0:
      //           return ctr0.scrollController.value.jumpTo(0);
      //         case 1:
      //           return ctr1.scrollController.value.jumpTo(0);
      //         case 2:
      //           return ctr2.scrollController.value.jumpTo(0);
      //         case 3:
      //           return ctr3.scrollController.value.jumpTo(0);
      //         case 4:
      //           return ctr4.scrollController.value.jumpTo(0);
      //       }
      //     }),
    );
  }

  Widget _floatTabBar() {
    return SimpleTabBar(
      initialIndex: 0,
      tabs: [
        Tab(text: 'home'.tr),
        Tab(text: 'best'.tr),
        Tab(text: 'new'.tr),
        Tab(text: 'Dingdong'.tr),
        Tab(text: 'dingpick'.tr)
      ],
      tabBarViews: [
        Tab1HomeView(),
        Tab2BestView(),
        Tab3NewProductsView(),
        Tab4DingDongView(),
        Tab5DingPickView(),
      ],
    );
  }

  AppBar _mainAppbar() {
    return MainAppbar(
      isBackEnable: false,
      actions: [
        IconButton(
          icon: Image.asset("assets/icons/top_search.png",color: Colors.black,height: 21,),
          onPressed: () {
            Get.to(() => SearchPageView());
          },
        ),
        Obx(
          () => cartCtr.getNumberProducts() != 0
              ? Badge(
                  badgeColor: MyColors.primary,
                  badgeContent: Text(
                    cartCtr.getNumberProducts().toString(),
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
                      )),
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
}
