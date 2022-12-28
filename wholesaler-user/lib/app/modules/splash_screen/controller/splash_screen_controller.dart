import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/main/view/partner_main_view.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/modules/main/view/user_main_view.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    bool isLogin = await CacheProvider().getToken().isNotEmpty;
    isLogin
        ? MyVars.isUserProject()
            ?  Get.offAll(() => UserMainView())
            : Get.offAll(() => PartnerMainView())
        : Future.delayed(Duration(seconds: 1),() => Get.offAll(() => User_LoginPageView()));

    super.onInit();
  }
}
