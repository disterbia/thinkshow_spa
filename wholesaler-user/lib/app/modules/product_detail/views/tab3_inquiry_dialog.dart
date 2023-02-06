import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/tab_3_inquiry_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/product_inquiry_view.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

// Future<dynamic> SubmitInquiryDialog() {
//   Tab3InquiryController ctr = Get.put(Tab3InquiryController());
//   return showDialog(
//       context: Get.context!,
//       builder: (context) {
//         return Dialog(
//           insetPadding: EdgeInsets.symmetric(horizontal: 20),
//           shape: RoundedRectangleBorder(
//               borderRadius:
//                   BorderRadius.all(Radius.circular(MyDimensions.radius))),
//           child: Padding(
//             padding: const EdgeInsets.all(15),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Center(child: Text('Register_product_inquiry'.tr)),
//                 SizedBox(height: 15),
//                 TextField(controller: ctr.contentController,
//                   decoration: InputDecoration(
//                     floatingLabelBehavior: FloatingLabelBehavior.always,
//                     label: Text('문의내용'),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(MyDimensions.radius),
//                     ),
//                   ),
//                   maxLines: 6,
//                 ),
//                 SizedBox(height: 10),
//                 Obx(
//                   () => Row(
//                     children: [
//                       SizedBox(
//                         width: 22,
//                         height: 22,
//                         child: Checkbox(
//                             value: ctr.isSecret.value,
//                             activeColor: MyColors.primary,
//                             onChanged: (value) {
//                               ctr.isSecret.toggle();
//                             }),
//                       ),
//                       SizedBox(width: 5),
//                       GestureDetector(
//                         onTap: () => ctr.isSecret.toggle(),
//                         child: Text(
//                           '비밀글',
//                           style:
//                               MyTextStyles.f16.copyWith(color: MyColors.black2),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TwoButtons(
//                     rightBtnText: 'submit'.tr,
//                     leftBtnText: 'cancel'.tr,
//                     rBtnOnPressed: () {
//                       ctr.submitInquiryPressed();
//                       // Get.back();
//                     },
//                     lBtnOnPressed: () {
//                       Get.back();
//                     })
//               ],
//             ),
//           ),
//         );
//       });
// }

class InquityRegisterView extends GetView {
  Tab3InquiryController ctr = Get.put(Tab3InquiryController());

  @override
  Widget build(BuildContext context) {
    // myTest = 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar(isBackEnable: true, title: '상품 문의'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //상품 자리
          ProductInquiryView(
            product: ctr.product,
          ),
          Divider(thickness: 5, color: MyColors.grey3),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              '문의 유형',
              style: MyTextStyles.f16.copyWith(
                  color: MyColors.black3, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
              onTap: () {
                showBottomCategory(context);
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: MyColors.grey1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => ctr.inquiresCategoiesIndex.value == -1
                          ? Text(
                              '문의 유형을 선택해주세요.',
                              style: MyTextStyles.f14
                                  .copyWith(color: MyColors.grey10),
                            )
                          : Text(
                              ctr
                                  .inquiresCategoiesList[
                                      ctr.inquiresCategoiesIndex.value]
                                  .name!,
                              style: MyTextStyles.f14
                                  .copyWith(color: MyColors.black2),
                            ),
                    ),
                    Image.asset(
                      'assets/icons/ico_arrow_down.png',
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '내용',
                  style: MyTextStyles.f16.copyWith(
                      color: MyColors.black3, fontWeight: FontWeight.w500),
                ),
                Obx(
                  () => Row(
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: Checkbox(
                            value: ctr.isSecret.value,
                            activeColor: MyColors.primary,
                            onChanged: (value) {
                              ctr.isSecret.toggle();
                            }),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => ctr.isSecret.toggle(),
                        child: Text(
                          '비밀글',
                          style: MyTextStyles.f16.copyWith(
                              color: MyColors.black2,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: ctr.contentController,
              decoration: InputDecoration(
                hintText: '문의 내용을 작성해주세요.',
                hintStyle: MyTextStyles.f14.copyWith(color: MyColors.grey10),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(MyDimensions.radius),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(MyDimensions.radius),
                  borderSide: BorderSide(width: 1, color: MyColors.grey1),
                ),
              ),
              maxLines: 6,
            ),
          ),

          Spacer(),
          Divider(
            color: MyColors.grey1,
          ),
          Container(
            height: Get.height / 17,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ))),
                  onPressed: () {
                    ctr.submitInquiryPressed();
                  },
                  child: Text("문의하기",
                      style: MyTextStyles.f16_bold
                          .copyWith(color: MyColors.white))),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  showBottomCategory(BuildContext context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Obx(
          () => Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  '문의 유형',
                  style: MyTextStyles.f16.copyWith(
                      color: MyColors.black3, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                for (int i = 0; i < ctr.inquiresCategoiesList.length; i++) ...[
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      print(i);
                      ctr.inquiresCategoiesIndex.value = i;
                      Navigator.pop(context);
                    },
                    title: Text(
                      ctr.inquiresCategoiesList[i].name!,
                      style: MyTextStyles.f14.copyWith(color: MyColors.grey10),
                    ),
                  )
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
