import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wsu_app/helpers/helpers.dart';

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

  signIn() async {
    if (isSigningIn.isTrue) return;

    isSigningIn.value = true;

    print("here");

    try {
      if (email == null || email.isBlank) throw 'Enter your email';

      if (password == null || password.isBlank) throw 'Enter your password';

      var cred = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: password);

      print(cred);

      Get.offAndToNamed('/splash');
    } on FirebaseAuthException catch (e) {
      toast(e.message);
    } catch (e) {
      toast(e);
    }

    isSigningIn.value = false;
  }
}
