import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final inputController = TextEditingController();
  final passwordController = TextEditingController();

  String email = '';
  String password = '';

  var obscurePassword = true.obs;
  var isSigningIn = false.obs;
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    inputController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
