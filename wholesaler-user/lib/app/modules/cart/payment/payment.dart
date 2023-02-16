import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/* 아임포트 결제 모듈을 불러옵니다. */
import 'package:iamport_flutter/iamport_payment.dart';
/* 아임포트 결제 데이터 모델을 불러옵니다. */
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart2_payment_controller.dart';
import 'package:wholesaler_user/app/modules/order_inquiry_and_review/views/order_inquiry_and_review_view.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';
import 'package:js/js.dart';
import 'dart:js' as js;

@JS('functionName')
external set _functionName(void Function() f);

class Payment extends StatelessWidget {
  Cart2PaymentController cart2Ctr = Get.put(Cart2PaymentController());
  Payment();

  void _someDartFunction() {
    js.JsObject obj = js.JsObject.fromBrowserObject(js.context['add']);
    print("pg:${obj['pg'].toString()}");
    print("merchant_uid:${obj['merchant_uid'].toString()}");
    print("amount:${obj['amount'].toString()}");
    print("buyName:${obj['buyName'].toString()}");
    print("buyerTel:${obj['buyerTel'].toString()}");
    print("buyerEmail:${obj['buyerEmail'].toString()}");
    print("buyerAddr:${obj['buyerAddr'].toString()}");
    print("buyerPostcode:${obj['buyerPostcode'].toString()}");
    print("uid:${obj['imp_uid'].toString()}");
    print("merchantUid:${obj['merchant_uid']}");
    print("result:${obj['result']}");
    print("status:${obj['status']}");
    print("test:${obj['test']}");
    if(obj['result']){
      cart2Ctr.paymentSuccessful(obj['imp_uid'],obj['merchant_uid']);
    }else{
      mSnackbar(message: '결제에 실패하였습니다.',);
      Get.back();
      Get.back();
    }

    // ctr.address1Controller.text = obj['zonecode'].toString();
    // ctr.address2Controller.text = obj['addr'].toString();
    // _extraAdress.text=obj['extraAddr'].toString();
  }
  void payWithIamport(String userCode,String pg,String merchant_uid,int amount,String buyName,String buyerTel,
      String buyerEmail,String buyerAddr,String buyerPostcode)  {
    // Use the JavaScript interop API to call the JavaScript function
    js.context.callMethod('requestPay', [userCode,pg, merchant_uid, amount, buyName, buyerTel,
      buyerEmail, buyerAddr, buyerPostcode]);
  }
  @override
  Widget build(BuildContext context) {
    _functionName = allowInterop(_someDartFunction);
    payWithIamport(cart2Ctr.cart2checkoutModel.value.iamportInfo!.iamportId!
        ,cart2Ctr.cart2checkoutModel.value.iamportInfo!.pg!,
        cart2Ctr.cart2checkoutModel.value.iamportInfo!.merchantUid!.toString(),
        cart2Ctr.cart2checkoutModel.value.totalProductAmount.value,
        cart2Ctr.nameController.text,cart2Ctr.phoneFirstPartController.text +
            cart2Ctr.phoneSecondPartController.text +
            cart2Ctr.phoneThirdPartController.text,
        cart2Ctr.cart2checkoutModel.value.userInfo!.email!,
        cart2Ctr.address2Controller.text,
        cart2Ctr.address1ZipCodeController.text);
    return Container();

  }
}
