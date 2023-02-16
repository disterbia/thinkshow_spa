import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wholesaler_partner/app/Constant/languages.dart';
import 'package:wholesaler_partner/my_custom_scroll_behavior.dart';

import 'package:wholesaler_partner/app/modules/ad/views/ad_view.dart';
import 'package:wholesaler_user/app/constants/theme.dart';
import 'package:wholesaler_user/app/Constants/variables.dart';
import 'package:wholesaler_user/app/modules/splash_screen/view/splash_screen_view.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await MyVars.initializeVariables();

  setUrlStrategy(null);
  runApp(
    FlutterWebFrame(maximumSize: Size(500,double.infinity),
      builder: (context) =>
       GetMaterialApp(
          localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('ko', 'KR'),
          ],
          translations: pLanguages(),
          locale: const Locale('ko', 'KR'),
          fallbackLocale: const Locale('ko', 'KR'),
          theme: appThemeDataLight,
          debugShowCheckedModeBanner: false,
          title: "띵쇼마켓 (도매)",
          home: SplashScreenPageView(),
         scrollBehavior: MyCustomScrollBehavior(),
          // getPages: [
          //   GetPage(name: '/login', page: () => User_LoginPageView()),
          // ]
      ),
    ),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.to(() => AdView(), arguments: 2);
    });
    return Container();
  }
}
