import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';

mSnackbar(
    {required String message,
    String? actionText,
    VoidCallback? onPressed,
    int duration = 2}) {
  final snackBar = SnackBar(
    backgroundColor: Color.fromARGB(210, 43, 43, 43),
    content: Text(message),
    padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
    action: SnackBarAction(
      label: actionText ?? '',
      onPressed: onPressed ?? () {},
    ),
    duration: Duration(seconds: duration),
  );
  ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
}
