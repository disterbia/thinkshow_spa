import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/controllers/register_ceo_employee_4_controller.dart';
import 'package:wholesaler_user/app/constants/constants.dart';
import 'package:wholesaler_user/app/widgets/field_with_button.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/widgets/phone_number_textfield/phone_number_textfield_controller.dart';

class PhoneNumberPhoneVerify2 extends GetView {
  RegisterCeoEmployee4Controller ctr2 =
  Get.put(RegisterCeoEmployee4Controller());

  double spaceBetween;
  PhoneNumberPhoneVerify2({required this.spaceBetween});

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
            readOnly: !ctr2.verifyIsEnable.value,
            isTextKeyboard: true,
            fieldLabel: '휴대폰 번호',
            fieldText: '휴대폰 번호 입력',
            fieldController:ctr2.phoneNumCtr,
            buttonText: 'verify'.tr,
            onTap: ctr2.verifyIsEnable.value
                ? () {
              ctr2.requestVerifyPhonePressed();
            }
                : null,
            inputFormatters: [
              LengthLimitingTextInputFormatter(11),
              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
            ],
          ),
        ),
        Obx(() => !ctr2.verifyIsEnable.value
            ? Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child:
              Text(formatedTime(timeInSecond: ctr2.verifyCount.value)),
            ),
            SizedBox(height: spaceBetween),
            CustomField(
              readOnly: ctr2.verifyIsEnable.value,
              isTextKeyboard: true,
              fieldLabel: '인증번호 입력',
              fieldText: '인증번호 입력',
              fieldController: ctr2.phoneNumVerifyCtr,
              buttonText: 'ok'.tr,
              onTap: !ctr2.verifyIsEnable.value
                  ? () {
                ctr2.verifyPhonePressed();
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
