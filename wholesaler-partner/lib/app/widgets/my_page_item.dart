import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPageItem extends StatelessWidget {
  String title;
  VoidCallback onPressed;
  MyPageItem({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: !GetPlatform.isMobile?500:Get.width,
        child: TextButton(
          onPressed: onPressed,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
