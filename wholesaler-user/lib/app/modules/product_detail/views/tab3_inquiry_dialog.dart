import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/tab_3_inquiry_controller.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //상품 자리
            Divider(thickness: 6, color: MyColors.grey3),
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
                onTap: () {},
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
                      Text(
                        '문의 유형을 선택해주세요.',
                        style:
                            MyTextStyles.f14.copyWith(color: MyColors.grey10),
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
          ],
        ),
      ),
    );
  }
}
