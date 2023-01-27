import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                      mSnackbar(message: '같은 소재는 입력이 불가능합니다.');
                      fieldController.clear();

                      return;
                    }
                  }

                  tagList.add(value);
                  percentList == null
                      ? null
                      : percentList!.add(TextEditingController());
                  fieldController.clear();

                  materialPercentCheck!.value = 0;
                  for (int k = 0; k < percentList!.length; k++) {
                    if (percentList![k].text.isNotEmpty) {
                      materialPercentCheck!.value +=
                          int.parse(percentList![k].text);
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
                        tagList.removeAt(i);
                        percentList == null ? null : percentList!.removeAt(i);

                        materialPercentCheck!.value = 0;
                        for (int k = 0; k < percentList!.length; k++) {
                          if (percentList![k].text.isNotEmpty) {
                            materialPercentCheck!.value +=
                                int.parse(percentList![k].text);
                          }

                          // print(ctr.materialTypePercentControllers[k].text);
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
