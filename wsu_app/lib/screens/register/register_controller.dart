import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wsu_app/api/auth_api.dart';
import 'package:wsu_app/helpers/helpers.dart';

class RegisterScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final inputController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var _authApi = Get.put(AuthApi());

  String email = '';
  String password = '';
  String username = '';

  var obscurePassword = true.obs;
  var isSigningUp = false.obs;
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    inputController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  signUp() async {
    if (isSigningUp.isTrue) return;

    isSigningUp.value = true;

    try {
      if (email.isBlank) throw 'Enter your email';
      if (username.isBlank) throw 'Enter your username';

      if (password.isBlank) throw 'Enter your password';

      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.trim(), password: password);

      await _authApi.register({"displayName": username.trim()});

      Get.offAndToNamed('/splash');
    } on FirebaseAuthException catch (e) {
      toast(e.message);
    } catch (e) {
      toast(e);
    }

    isSigningUp.value = false;
  }
}
