import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';

import '../../controller/add_product_controller.dart';

class CustomInput extends GetView<AddProductController> {
  final String label;
  final TextEditingController fieldController;
  final String? prefix;
  final TextInputType keyboardType;
  final String? hintText;
  final Function(String)? onChanged;
  const CustomInput(
      {Key? key,
      required this.label,
      required this.fieldController,
      this.prefix,
      this.hintText,
      this.keyboardType = TextInputType.text,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.grey1,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: !GetPlatform.isMobile?500/4:Get.width/4,
              child: Text(
                label,
                style: MyTextStyles.f14.copyWith(color: MyColors.black2),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  _textField(keyboardType, hintText),
                  SizedBox(width: 10),
                  prefix == null
                      ? SizedBox()
                      : Text(
                          prefix!,
                          style:
                              MyTextStyles.f14.copyWith(color: MyColors.grey10),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _textField(keyboardType, hintText) {
    return Expanded(
      child: SizedBox(
        height: 30,
        child: TextField(
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'^0+')),
          ],
          onChanged: onChanged,
          controller: fieldController,
          keyboardType: keyboardType,
          // maxLines: 1,
          minLines: 1,
          decoration: InputDecoration(
              hintText: hintText ?? '',
              hintStyle: TextStyle(color: MyColors.grey11, fontSize: 12),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.orange,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              filled: true,
              fillColor: Colors.white),
        ),
      ),
    );
  }
}
