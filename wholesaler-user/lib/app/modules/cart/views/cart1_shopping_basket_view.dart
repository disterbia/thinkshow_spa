import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart1_shopping_basket_controller.dart';
import 'package:wholesaler_user/app/modules/cart/views/cart2_payment_view.dart';
import 'package:wholesaler_user/app/modules/cart/widgets/cart_items_list_widget.dart';
import 'package:wholesaler_user/app/modules/cart/widgets/circular_checkbox.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class Cart1ShoppingBasketView extends GetView {
  Cart1ShoppingBasketController ctr = Get.put(Cart1ShoppingBasketController());

  Cart1ShoppingBasketView();
  RxDouble expandableHeight = (Get.height / 6).obs;
  RxBool isFirstDrag = true.obs;
  RxBool isExpanded = false.obs;
  init() async {
    await ctr.init();
    await ctr.SelectAllCheckboxOnChanged(false);
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      backgroundColor: MyColors.grey3,
      appBar: CustomAppbar(isBackEnable: true, title: '장바구니'),
      body: Obx(() => ctr.isLoading.value ? LoadingWidget() : body(context)),
    );
  }

  Widget body(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                color: Colors.white,
                child: Row(
                  children: [
                    _selectAllCheckbox(),
                    Spacer(),
                    _deleteTextButtons(),
                  ],
                ),
              ),
              //Divider(thickness: 10, color: MyColors.grey3),
              // empty cart
              Obx(() => ctr.cartItems.isEmpty
                  ? Column(
                      children: [
                        SizedBox(height: 40),
                        Text('상품 없음'),
                      ],
                    )
                  : SizedBox.shrink()),
              // Cart
              SizedBox(height: 15),
              CartItemsList(
                isCart1Page: true,
                cartItems: ctr.cartItems,
                showClose: true,
              ),
              Obx(
                () => Container(
                  height: expandableHeight.value,
                ),
              )
            ],
          ),
        ),
        Obx(
          () => ExpandableNotifier(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: expandableHeight.value,
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 25, color: Colors.black.withOpacity(0.2)),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                          child: isExpanded.value
                              ? _expandSection()
                              : _collaspeSection()
                          // Expandable(
                          //     collapsed: _collaspeSection(), expanded: _expandSection()),
                          ),
                    ),
                    Container(height: Get.height / 15, child: _paymentButton()),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _selectAllCheckbox() {
    return Row(
      children: [
        Obx(
          () => CustomCheckbox(
            isChecked: ctr.isSelectAllChecked.value,
            onChanged: (bool value) => ctr.SelectAllCheckboxOnChanged(value),
          ),
        ),
        GestureDetector(
            onTap: () {
              ctr.SelectAllCheckboxOnChanged(!ctr.isSelectAllChecked.value);
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '전체선택',
                    style: MyTextStyles.f14.copyWith(color: MyColors.black3),
                  ),
                ),
                Obx(
                  () => Text(
                    '(${ctr.getTotalSelectedProducts()}/${ctr.getNumberProducts()})',
                    style: MyTextStyles.f14.copyWith(color: MyColors.black1),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget _deleteTextButtons() {
    return Row(
      children: [
        InkWell(
          onTap: () => ctr.cartItems.isEmpty
              ? mSnackbar(message: "상품이 없습니다.")
              : ctr.getTotalSelectedProducts() == 0
                  ? mSnackbar(message: "선택된 상품이 없습니다.")
                  : ctr.deleteSelectedProducts(),
          child: Text(
            '선택삭제',
            style: MyTextStyles.f14.copyWith(color: MyColors.grey4),
          ),
        ),
        Container(
            height: 15,
            child: VerticalDivider(
              thickness: 2,
              color: MyColors.grey4,
            )),
        InkWell(
          onTap: () => ctr.cartItems.isEmpty
              ? mSnackbar(message: "상품이 없습니다.")
              : ctr.deleteAllProducts(),
          child: Text(
            '전체삭제',
            style: MyTextStyles.f14.copyWith(color: MyColors.grey4),
          ),
        ),
      ],
    );
  }

  Widget _collaspeSection() {
    return Builder(builder: (context) {
      var controller = ExpandableController.of(
        context,
        required: true,
      )!;
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 20, top: 20),
            child: Text(
              "결제 예상금액",
              style: MyTextStyles.f14,
            ),
          ),
          Spacer(),
          Obx(() => Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 20),
                child: Text(
                  Utils.numberFormat(
                      number: ctr.totalPaymentPrice.value, suffix: '원'),
                  style: MyTextStyles.f14_bold,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(bottom: 10, top: 15, right: 20),
            child: InkWell(
                onTap: () {
                  isExpanded.value = true;
                  controller.toggle();
                  expandableHeight.value = Get.height / 3;
                  isFirstDrag.value = true;
                },
                child: Icon(Icons.keyboard_arrow_up_outlined, size: 30)),
          ),
        ],
      );
    });
  }

  Widget _expandSection() {
    return Builder(builder: (context) {
      var controller = ExpandableController.of(context, required: true)!;
      return GestureDetector(
        onPanUpdate: (details) {
          if (!isFirstDrag.value) return;
          if (details.delta.dy > 0.2) {
            isExpanded.value = false;
            controller.toggle();
            expandableHeight.value = Get.height / 6;
            isFirstDrag.value = false;
          }
        },
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 20),
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: MyColors.grey3,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.grey3,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, bottom: 5),
                        child: Row(
                          children: [
                            Text(
                              "총 상품금액",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Spacer(),
                            Obx(() => Padding(
                                  padding: EdgeInsets.only(
                                      top: 8, right: 8, bottom: 5),
                                  child: Text(
                                    Utils.numberFormat(
                                      number: ctr.totalPaymentPrice.value,
                                      suffix: '원',
                                    ),
                                    style: MyTextStyles.f14_bold,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 5),
                        child: Row(
                          children: [
                            Text("총 배송비", style: TextStyle(color: Colors.grey)),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 8, bottom: 5),
                              child: Text(
                                Utils.numberFormat(number: 0, suffix: '원'),
                                style: MyTextStyles.f14_bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          bottom: 10,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "결제 예상금액",
                              style: MyTextStyles.f14,
                            ),
                            Spacer(),
                            Obx(() => Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Text(
                                    Utils.numberFormat(
                                        number: ctr.totalPaymentPrice.value,
                                        suffix: '원'),
                                    style: MyTextStyles.f14_bold,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _paymentButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () async {
            if (ctr.getTotalSelectedProducts() != 0) {
              await ctr.postOrderCheckout();
            } else {
              mSnackbar(message: '상품을 선택해주세요.');
            }
          },
          child: Obx(() => Text(
              "총 ${ctr.getTotalSelectedProducts().toString()}개 주문하기",
              style: MyTextStyles.f14.copyWith(color: MyColors.white)))),
    );
  }
}
