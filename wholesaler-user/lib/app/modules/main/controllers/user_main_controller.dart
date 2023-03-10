import 'dart:collection';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/functions.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/models/user_model.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/modules/main/view/user_main_view.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/tabs/tab1_home.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/tabs/tab2_best.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/tabs/tab3_new_products.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/tabs/tab4_ding_dong.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/tabs/tab5_ding_pick.dart';
import 'package:wholesaler_user/app/modules/page4_favorite_products/controllers/page4_favorite_products_controller.dart';
import 'package:wholesaler_user/app/widgets/simple_tab_bar.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class UserMainController extends GetxController {
  // RxInt selectedIndex = 0.obs;

  // void onItemTapped(int index) {
  //   // setState(() {
  //   tabIndex.value = index;
  //   // });
  // }

  RxInt tabIndex = UseBottomNavTabs.home.index.obs;
  RxInt changed = 0.obs;
  // Rx<ListQueue> navigationQueue = ListQueue().obs;


  void changeTabIndex(int index) {
    changed.value++;
    if (index == UseBottomNavTabs.favorites.index ||
        index == UseBottomNavTabs.my_page.index ||
        index == UseBottomNavTabs.store.index) {
      // check if user is logged in
      if (CacheProvider().getToken().isEmpty) {
         mFuctions.userLogout();
        return mSnackbar(message: "로그인 후 이용 가능합니다.");
      }
      // Get.delete<Page4Favorite_RecentlyViewedController>(); // If we don't delete, the title would be 최근본사품 instead of 찜
    }

    // navigationQueue.value.addLast(index);
    tabIndex.value = index;
    update();
  }

  DateTime? currentBackPressTime;

  onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      mSnackbar(message: "'뒤로' 버튼을 한번 더 누르시면 종료됩니다.");
      return false;
    }
    SystemNavigator.pop();
    return true;

    // if (navigationQueue.value.length == 1) {
    //   exit(0);
    // } else {
    //   navigationQueue.value.removeLast();
    //   tabIndex.value = navigationQueue.value.last;
    //   update();
    //   return false;
    // }
  }
}
