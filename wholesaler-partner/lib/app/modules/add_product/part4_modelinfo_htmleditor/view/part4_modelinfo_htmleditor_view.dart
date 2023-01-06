import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wholesaler_partner/app/modules/add_product/part4_modelinfo_htmleditor/controller/part4_modelinfo_htmleditor_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/custom_input.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/editor_widget/editor_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';

/// 모델정보
class AP_Part4View extends GetView<AP_Part4Controller> {
  AP_Part4Controller ctr = Get.put(AP_Part4Controller());
  /*RxList<XFile> pickedFile = <XFile>[].obs;*/


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            '모델정보',
            style: MyTextStyles.f16.copyWith(color: MyColors.black2),
          ),
          SizedBox(height: 14),
          CustomInput(
            label: '키',
            fieldController: ctr.modelHeightController,
            prefix: 'CM',
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 5),
          CustomInput(
            keyboardType: TextInputType.number,
            label: '몸무게',
            fieldController: ctr.modelWeightController,
            prefix: 'KG',
          ),
          SizedBox(height: 5),
          CustomInput(
            label: '사이즈',
            fieldController: ctr.modelSizeController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 30),
          EditorWidget(),
          SizedBox(height: 30),
          // Obx(
          //       () => Container(
          //     height: 100,
          //     width: Get.width,
          //     child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemCount: pickedFile.length,
          //       itemBuilder: (context, index) {
          //         return Badge(badgeColor: MyColors.primary,
          //             badgeContent: GestureDetector(
          //               child: Icon(Icons.remove_circle_outline,size: 20),
          //               onTap: () {
          //                 print(index);
          //                 pickedFile.removeAt(index);
          //               },
          //             ),
          //             child: Container(
          //               width: 50,
          //               child: Image.file(File(pickedFile[index].path),),
          //
          //             ));
          //       },
          //     ),
          //   ),
          // ),
          SizedBox(height: 30,),
          // CustomButton(
          //   onPressed: () async {
          //     pickedFile.value = await ImagePicker().pickMultiImage();
          //   },
          //   text: "이미지 업로드",
          //   width: double.infinity,
          // ),

        ],
      ),
    );
  }
}
