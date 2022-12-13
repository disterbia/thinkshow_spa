import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTagField extends StatelessWidget {
  final String? hintText;
  final RxList<String> tagList;
  final TextEditingController fieldController;
  final Function()? onAddTag;
  final Function(int index)? onDeleteTag;

  const AddTagField(
      {this.hintText,
      required this.tagList,
      required this.fieldController,
      this.onDeleteTag,
      this.onAddTag});

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
                  tagList.add(value);
                  fieldController.clear();
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
                        if (onDeleteTag != null) {
                          onDeleteTag!(i);
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
