import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';

class ChipWidget extends StatelessWidget {
  String title;
  void Function() onTap;
  bool isSelected;
  ChipWidget(
      {required this.title, required this.onTap, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: isSelected ? MyColors.primary : MyColors.grey1,
                width: 1),
            borderRadius: BorderRadius.circular(10)),
        backgroundColor: isSelected ? MyColors.primary : MyColors.white,
        label: Text(
          title,
          style: TextStyle(color: isSelected ? Colors.white : MyColors.black),
        ),
      ),
    );
  }
}
