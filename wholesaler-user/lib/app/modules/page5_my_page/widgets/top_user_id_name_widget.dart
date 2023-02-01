// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/user_model.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/views/my_Page_settings_view.dart';

class TopUserIDUserNameSettings extends StatelessWidget {
  User user;
  bool showSettingsIcon;
  TopUserIDUserNameSettings(
      {required this.user, required this.showSettingsIcon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => MyPageSettingsView());
      },
      child: Row(
        mainAxisAlignment: showSettingsIcon
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: showSettingsIcon
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              // User ID
              SizedBox(
                height: 20,
              ),
              Text(
                user.userName,
                style: MyTextStyles.f18_bold.copyWith(
                    color: MyColors.black2, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),

              Row(
                children: [
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    user.userID,
                    style: MyTextStyles.f12.copyWith(color: MyColors.grey10),
                  ),
                ],
              ),
              // User Name

              SizedBox(
                height: 20,
              ),
            ],
          ),
          // Spacer(),
          // Settings Icon
          showSettingsIcon
              ? Image.asset(
                  'assets/icons/ico_arrow02.png',
                  height: 25,
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
