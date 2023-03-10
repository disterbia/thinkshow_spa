import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/main/view/partner_main_view.dart';
import 'package:wholesaler_partner/app/modules/page3_my_info_mgmt/controllers/my_info_mgmt_controller.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/modules/auth/password_reset/controller/password_reset_controller.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/modules/main/controllers/user_main_controller.dart';

class mFuctions {
  static void userLogout() {
    CacheProvider cacheProvider = CacheProvider();
    // delete all Get Controllers

    cacheProvider.removeToken();
    cacheProvider.removeOwner();
    cacheProvider.removePrivilege();
    cacheProvider.removeRecentlyViewedProduct();

    Get.offAll(() => User_LoginPageView());
  }

  static void storeLogout() {
    CacheProvider cacheProvider = CacheProvider();

    cacheProvider.removeFCMToken();
    cacheProvider.removeToken();
    cacheProvider.removeUserId();

    // cacheProvider.removeToken();
    // cacheProvider.removeOwner();
    // cacheProvider.removePrivilege();

    Get.offAll(() => User_LoginPageView());
  }
}
