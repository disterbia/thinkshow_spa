import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/add_product/option.dart';
import 'package:wholesaler_partner/app/modules/add_product/controller/add_product_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/part1_category_image_keyword/controller/part1_category_image_keyword_controller.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class AddTagField extends StatelessWidget {
  final String? hintText;
  final RxList<String> tagList;
  final TextEditingController fieldController;
  final List<TextEditingController>? percentList;
  final RxInt? materialPercentCheck;

  const AddTagField({
    this.hintText,
    required this.tagList,
    required this.fieldController,
    this.percentList,
    this.materialPercentCheck,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Obx(
            () => Column(
          children: [
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    hintText: hintText,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 0.0)),
                controller: fieldController,
                onSubmitted: (value) {
                  for (int k = 0; k < tagList.length; k++) {
                    if (value == tagList[k]) {
                      mSnackbar(message: '같은 내용은 입력이 불가능합니다.');
                      fieldController.clear();

                      return;
                    }
                  }

                  tagList.add(value);
                  percentList == null
                      ? null
                      : percentList!.add(TextEditingController());
                  fieldController.clear();
                  if(materialPercentCheck!=null) {
                    materialPercentCheck!.value = 0;
                    for (int k = 0; k < percentList!.length; k++) {
                      if (percentList![k].text.isNotEmpty) {
                        materialPercentCheck!.value +=
                            int.parse(percentList![k].text);
                      }
                    }
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 4,
                children: [
                  for (var i = 0; i < tagList.length; i++)
                    Chip(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0))),
                      label: Text(tagList[i]),
                      onDeleted: () {
                        int temp =0;
                        for(int j=0;j<Get.find<AddProductController>().options.length;j++){
                          if(tagList[i]==Get.find<AddProductController>().options[j].color){
                            temp++;
                            //Get.find<AddProductController>().colorsList.removeAt(j);
                          }
                        }
                        for(int k =0; k<temp ; k++)  Get.find<AddProductController>().optionsControllers.removeLast();
                        Get.find<AddProductController>().options.removeWhere((element) => element.color==tagList[i]);
                        tagList.removeAt(i);
                        percentList == null ? null : percentList!.removeAt(i);
                        if(materialPercentCheck!=null) {
                          materialPercentCheck!.value = 0;
                          for (int k = 0; k < percentList!.length; k++) {
                            if (percentList![k].text.isNotEmpty) {
                              materialPercentCheck!.value +=
                                  int.parse(percentList![k].text);
                            }

                            // print(ctr.materialTypePercentControllers[k].text);
                          }
                        }
                      },
                      deleteIconColor: Colors.grey,
                      backgroundColor: Colors.grey.withOpacity(0.3),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
