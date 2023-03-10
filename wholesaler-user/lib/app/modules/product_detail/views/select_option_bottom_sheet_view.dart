import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wholesaler_user/app/Constants/colors.dart';
import 'package:wholesaler_user/app/Constants/styles.dart';
import 'package:wholesaler_user/app/models/product_option_model.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart1_shopping_basket_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/dropdown_widget.dart';
import 'package:wholesaler_user/app/widgets/product/quantity_plus_minus_widget.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

Future<dynamic> SelectOptionBottomSheet() {
  ProductDetailController ctr = Get.put(ProductDetailController());
  Cart1ShoppingBasketController ctr2 = Get.put(Cart1ShoppingBasketController());

  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                // option title, option drop down
                Text(
                  '옵션',
                  style: MyTextStyles.f14.copyWith(color: MyColors.black3),
                ),
                SizedBox(height: 5),
                Obx(
                  () => Container(
                    child: mOptionDropDownButton(
                        label: '옵션을 선택해주세요',
                        options: ctr.product.value.options!,
                        isPrivilege: ctr.product.value.isPrivilege!),
                  ),
                ),
                SizedBox(height: 20),
                // quantity
                // Text(
                //   '수량',
                //   style: MyTextStyles.f14.copyWith(color: MyColors.black3),
                // ),
                SizedBox(height: 5),
                Obx(
                  () => Container(
                    height: ctr.optionList.length>2?60:30.0*ctr.optionList.length,
                    child: SingleChildScrollView(physics: ClampingScrollPhysics(),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) => Divider(),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ctr.optionList.length,
                        itemBuilder: (context, index) {
                          int addPrice = ctr.optionList[index].add_price ?? 0;
                          return Row(
                            children: [
                              Text(ctr.optionList[index].name!),
                              ctr.product.value.isDeal!?Container():Obx(
                                () => QuantityPlusMinusWidget(
                                  quantity: ctr.quantityList[index],
                                  onTap: (isRightTapped) {
                                    print('isRightTapped $isRightTapped');
                                    if (isRightTapped) {
                                      ctr.quantityList[index]++;
                                      ctr.UpdateTotalPrice();
                                    } else {
                                      if (ctr.quantityList[index] > 1) {
                                        ctr.quantityList[index]--;
                                        ctr.UpdateTotalPrice();
                                      }
                                    }
                                  },
                                ),
                              ),
                              Spacer(),
                              Obx(() => Text(
                                  ((ctr.product.value.price! + addPrice) *
                                              ctr.quantityList[index])
                                          .toString() + "원")),
                              SizedBox(width: 10,),
                              GestureDetector(
                                  child: Icon(Icons.close),
                                  onTap: () {
                                    ctr.optionList.removeAt(index);
                                    ctr.quantityList.removeAt(index);
                                    ctr.UpdateTotalPrice();
                                  }),

                              // QuantityPlusMinusWidget(
                              //   quantity: ctr.product.value.quantity!.value,
                              //   onTap: (isRightTapped) {
                              //     print('isRightTapped $isRightTapped');
                              //     if (isRightTapped) {
                              //       ctr.product.value.quantity!.value =
                              //           ctr.product.value.quantity!.value + 1;
                              //       ctr.UpdateTotalPrice();
                              //     } else {
                              //       if (ctr.product.value.quantity!.value > 1) {
                              //         ctr.product.value.quantity!.value =
                              //             ctr.product.value.quantity!.value - 1;
                              //         ctr.UpdateTotalPrice();
                              //       }
                              //     }
                              //   },
                              // ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Spacer(),
                Divider(thickness: 1, color: MyColors.grey1),
                SizedBox(height: 20),
                // total price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Text(
                      '총 금액',
                      style: MyTextStyles.f14.copyWith(color: MyColors.black3),
                    ),
                    Spacer(),
                    Obx(
                      () => Text(
                        Utils.numberFormat(number: ctr.totalPrice.value),
                        style:
                            MyTextStyles.f18_bold.copyWith(color: MyColors.red),
                      ),
                    ),
                    Text(
                      '원',
                      style: MyTextStyles.f16.copyWith(color: MyColors.black3),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TwoButtons(
                  leftBtnText: 'shopping_basket'.tr,
                  rightBtnText: '구매하기',
                  lBtnOnPressed: () {
                    ctr.purchaseBtnPressed(isDirectBuy: false);
                    ctr2.init();
                  },
                  rBtnOnPressed: () {
                    ctr.purchaseBtnPressed(isDirectBuy: true);
                    ctr2.init();
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      });
}
