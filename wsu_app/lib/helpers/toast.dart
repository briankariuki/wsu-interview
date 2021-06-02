import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wsu_app/config/palette.dart';

toast(e) {
  var message = e.toString();

  print("message");

  if (message.contains('NoSuchMethodError')) {
    message = 'Check your internet connection';

    print('Toast: $message');
  }

  Get.snackbar(
    "",
    message,
    snackPosition: SnackPosition.TOP,
    borderRadius: 5,
    margin: EdgeInsets.all(32),
    backgroundColor: Palette.black,
    colorText: Colors.white,
  );

  print('Toast: $e');
}
