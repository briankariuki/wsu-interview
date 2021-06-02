import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logout() async {
  await FirebaseAuth.instance.signOut();

  var prefs = await SharedPreferences.getInstance();

  await prefs.clear();

  Get.offAllNamed('/');

  print('Logged out');
}
