import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_user/app/Constants/constants.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class RegisterCeoEmployee4Controller extends GetxController {
  pApiProvider apiProvider = pApiProvider();

  TextEditingController phoneNumCtr = TextEditingController();
  TextEditingController phoneNumVerifyCtr = TextEditingController();
  int certifi_id = 0;
  bool isPhoneVerifyFinished = false;

  RxBool isAgreeAll = false.obs;
  RxBool isAgreeCondition = false.obs;
  RxBool isAgreePrivacy = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  RxInt verifyCount = mConst.verifyCountSecounds.obs;
  RxBool verifyIsEnable = true.obs;

  late Timer timer;
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (verifyCount <= 0) {
        timer.cancel();
        verifyIsEnable.value = true;
        verifyCount.value = mConst.verifyCountSecounds;
      } else {
        verifyCount.value--;
        verifyIsEnable.value = false;
      }
    });
  }

  Future<void> requestVerifyPhonePressed() async {
    log('verifyPhone');
    if (phoneNumCtr.text.isEmpty) {
      mSnackbar(message: '휴대폰 번호를 입력하세요.');
      return;
    }
    // check if only number
    if (!phoneNumCtr.text.contains(RegExp(r'^[0-9]*$'))) {
      mSnackbar(message: '휴대폰 번호는 숫자만 입력하세요.');
      return;
    }
    if (!phoneNumCtr.text
        .contains(RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$'))) {
      mSnackbar(message: '올바른 휴대폰 번호를 입력하세요.');
      return;
    }
    certifi_id = await apiProvider.postRequestVerifyPhoneNum(
        phoneNumber: phoneNumCtr.text);
    log('certifi_id is $certifi_id');

    startTimer();
  }

  Future<void> verifyPhonePressed() async {
    log('verifyPhonePresseddd');
    if (!phoneNumCtr.text.contains(RegExp(r'^[0-9]*$'))) {
      mSnackbar(message: '휴대폰 번호는 숫자만 입력하세요.');
      return;
    }
    print("-=-=${phoneNumVerifyCtr.text}");
    if (phoneNumVerifyCtr.text.isEmpty) {
      mSnackbar(message: '인증번호를 입력하세요.');
      return;
    }
    isPhoneVerifyFinished = await apiProvider.putPhoneNumVerify(
        phoneNumber: phoneNumCtr.text,
        phoneNumVerify: phoneNumVerifyCtr.text,
        certifi_id: certifi_id);

    timer.cancel();
    verifyIsEnable.value = true;
    verifyCount.value = mConst.verifyCountSecounds;
  }

  Future<void> registerBtnPressed() async {
    if (!isPhoneVerifyFinished) {
      mSnackbar(message: '인증번호를 입력하세요.'.tr);
      return;
    }
    if (isAgreeAll.isFalse) {
      mSnackbar(message: '이용약관 및 개인정보취급방침을 모두 동의하세요.'.tr);
      return;
    }

    if (certifi_id == 0) {
      mSnackbar(message: '휴대폰번호를 인증 하세요.');
      return;
    }

    bool isSuccess = await apiProvider.postCeoRegister();
    if (isSuccess) {
      mSnackbar(message: 'successfully_registered'.tr);

      Get.offAll(() => User_LoginPageView());
    } else {
      mSnackbar(message: 'registration_failed'.tr);
    }
  }

  Future<void> employeeRegisterBtnPressed() async {
    if (!isPhoneVerifyFinished) {
      mSnackbar(message: "휴대폰번호를 인증 하세요.");
      return;
    }
    if (isAgreeAll.isFalse) {
      mSnackbar(message: "이용약관 및 개인정보취급방침을 모두 동의하세요.");
      return;
    }

    if (certifi_id == 0) {
      mSnackbar(message: '휴대폰번호를 인증 하세요.');
      return;
    }

    bool isSuccess = await apiProvider.postStaffRegister();
    if (isSuccess) {
      mSnackbar(message: "정상적으로 가입 완료되었습니다.");

      Get.offAll(() => User_LoginPageView());
    } else {
      mSnackbar(message: "가입 실패되었습니다.");
    }
  }
}
