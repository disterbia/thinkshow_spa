import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wholesaler_user/app/widgets/field_with_button.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/widgets/phone_number_textfield/phone_number_textfield_controller.dart';

class PhoneNumberPhoneVerify extends StatelessWidget {
  PhoneNumberPhoneVerifyController ctr =
      Get.put(PhoneNumberPhoneVerifyController());

  double spaceBetween;
  PhoneNumberPhoneVerify({required this.spaceBetween});

  // void startTimer() {
  //   int _count = 120;
  //   Timer.periodic(Duration(seconds: 1), (Timer timer) {
  //     if(_count <= 0){
  //       timer.cancel();
  //     }
  //     else{
  //       _count--;
  //       print(_count);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomField(
          isTextKeyboard: true,
          fieldLabel: '휴대폰 번호',
          fieldText: '휴대폰 번호 입력',
          fieldController: ctr.numberController,
          buttonText: 'verify'.tr,
          onTap: () {
            ctr.verifyPhoneBtnPressed();
            // startTimer();
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(11),
            FilteringTextInputFormatter.allow(RegExp("[0-9]"))
          ],
        ),
        SizedBox(height: spaceBetween),
        CustomField(
          isTextKeyboard: true,
          fieldLabel: '인증번호 입력',
          fieldText: '인증번호 입력',
          fieldController: ctr.numberVerifyController,
          buttonText: 'ok'.tr,
          onTap: () {
            ctr.verifyCodeBtnPressed();
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(6),
            FilteringTextInputFormatter.allow(RegExp("[0-9]"))
          ],
        ),
      ],
    );
  }
}
