import 'package:flutter/material.dart';
import 'package:wholesaler_user/app/Constants/colors.dart';

class QuantityButton extends StatelessWidget {
  final IconData iconData;
  final BorderRadius leftBtnBorder;
  final VoidCallback onTap;
  const QuantityButton(this.iconData, this.leftBtnBorder, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency, //Makes it usable on any background color, thanks @IanSmith
        child: Ink(
          decoration: BoxDecoration(color: MyColors.grey3,
            border: Border.all(color: MyColors.grey3),
            borderRadius: leftBtnBorder,
          ),
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Icon(
                iconData,
                size: 9,
              ),
            ),
          ),
        ));
  }
}
