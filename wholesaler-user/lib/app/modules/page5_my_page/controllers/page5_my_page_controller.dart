import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_user/app/constants/functions.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/data/firebase_service.dart';
import 'package:wholesaler_user/app/models/user_model.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class Page5MyPageController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();
  RxBool isLoading = false.obs;
  Rx<User> user = User(userID: 'userID', userName: 'userName').obs;

  RxString serviceVersion = ''.obs;
  init() async {
    isLoading.value = true;

    if (CacheProvider().getToken().isNotEmpty) {
      //print('CacheProvider().getToken() : ${CacheProvider().getToken()}');

      bool result = await uApiProvider().chekToken();

      if (!result) {
        isLoading.value = false;

        print('logout');
        mSnackbar(message: '로그인 후 이용 가능합니다.');
         mFuctions.userLogout();
      } else {
        user.value = await _apiProvider.getUserInfo();
      }
    } else {
      mSnackbar(message: '로그인 후 이용 가능합니다.');
       mFuctions.userLogout();
    }
    isLoading.value = false;

    // user.value = await _apiProvider.getUserInfo();
  }

  deleteuserAccountBtnPressed() async {
    bool isSuccess = await _apiProvider.deleteUserAccount();

    if (isSuccess) {
      mSnackbar(message: '회원탈퇴가 완료되었습니다.');
      mFuctions.userLogout();
    } else {
      mSnackbar(message: '회원탈퇴에 실패하였습니다.');
    }
  }

  notificationToggled(bool value) async {
    bool isSuccess = await _apiProvider.updateNotification();

    if (isSuccess) {
      user.value.isAgreeNotificaiton!.value = value;
    }
  }

  getAppVersion() async {
    if (Platform.isAndroid)
      serviceVersion.value = await _apiProvider.getAppVersion('android');
    else if (Platform.isIOS)
      serviceVersion.value = await _apiProvider.getAppVersion('ios');
    else
      serviceVersion.value = await _apiProvider.getAppVersion('web');
  }
}
