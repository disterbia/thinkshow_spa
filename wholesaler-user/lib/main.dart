import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wholesaler_partner/my_custom_scroll_behavior.dart';
import 'package:wholesaler_user/app/constants/languages.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/modules/splash_screen/view/splash_screen_view.dart';
import 'app/constants/theme.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> main() async {
  print("-=-=-=-=${GetPlatform.isMobile}");
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await MyVars.initializeVariables();

  setUrlStrategy(null);
  runApp(
    FlutterWebFrame(maximumSize: Size(500,double.infinity),
      builder:(context) =>GetMaterialApp(
        translations: uLanguages(),
        locale: const Locale('ko', 'KR'),
        fallbackLocale: const Locale('ko', 'KR'),
        theme: appThemeDataLight,
        debugShowCheckedModeBanner: false,
        title: "띵쇼",
        // home: UserMainView(),
        home: SplashScreenPageView(),
        scrollBehavior: MyCustomScrollBehavior(),
      ),
    ),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get.to(() => ProductDetailView(), arguments: 9659);
      // Get.to(() => StoreDetailView(storeId: 10));
      // Get.to(() => ProductCategoryPageView(0));
      // Get.to(() => ExhibitionProductsView(), arguments: {'imageId': 1});

      // Get.to(() => OrderInquiryAndReviewView(hasHomeButton: false, isBackEnable: true), arguments: false);
    });
    return Container();
  }
}
