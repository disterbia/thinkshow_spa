import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wholesaler_user/app/constants/constants.dart';
import 'package:wholesaler_user/app/widgets/field_with_button.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/widgets/phone_number_textfield/phone_number_textfield_controller.dart';

class PhoneNumberPhoneVerify extends GetView {
  PhoneNumberPhoneVerifyController ctr =
      Get.put(PhoneNumberPhoneVerifyController());

  double spaceBetween;
  PhoneNumberPhoneVerify({required this.spaceBetween});

  formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => CustomField(
            readOnly: !ctr.verifyIsEnable.value,
            isTextKeyboard: true,
            fieldLabel: '휴대폰 번호',
            fieldText: '휴대폰 번호 입력',
            fieldController: ctr.numberController,
            buttonText: 'verify'.tr,
            onTap: ctr.verifyIsEnable.value
                ? () {
                    ctr.verifyPhoneBtnPressed();
                  }
                : null,
            inputFormatters: [
              LengthLimitingTextInputFormatter(11),
              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
            ],
          ),
        ),
        Obx(() => !ctr.verifyIsEnable.value
            ? Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child:
                        Text(formatedTime(timeInSecond: ctr.verifyCount.value)),
                  ),
                  SizedBox(height: spaceBetween),
                  CustomField(
                    readOnly: ctr.verifyIsEnable.value,
                    isTextKeyboard: true,
                    fieldLabel: '인증번호 입력',
                    fieldText: '인증번호 입력',
                    fieldController: ctr.numberVerifyController,
                    buttonText: 'ok'.tr,
                    onTap: !ctr.verifyIsEnable.value
                        ? () {
                            ctr.verifyCodeBtnPressed();
                          }
                        : null,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                      FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                    ],
                  ),
                ],
              )
            : SizedBox.shrink()),
      ],
    );
  }
}
