import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/variables.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/images.dart';
import 'package:wholesaler_user/app/modules/main/view/user_main_view.dart';

AppBar MainAppbar({String? title, required bool isBackEnable, IconData? icon, Function()? onPressed, Color? backgroundColor, List<Widget>? actions}) {
  return AppBar(
    leading:isBackEnable?
  Row(
    children: [
      Container(
        width: 40,
        height: 40,
        child: IconButton(
          onPressed: () {
            Get.offAll(() =>
                 UserMainView());
          },
          icon: Image.asset('assets/icons/ic_home.png'),
        ),
      )
    ],
  ):null,
    centerTitle: true,
    leadingWidth: 100,
    backgroundColor: backgroundColor ?? MyColors.white,
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Container(
        width: 50,
        height: 50,
        child: Image.asset(MyImages.logo),
      ),
    ),
    // leading: Row(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: <Widget>[],
    // ),
    actions: actions,
    elevation: 0,
    titleSpacing: 0.0,
    automaticallyImplyLeading: false,
  );
}
