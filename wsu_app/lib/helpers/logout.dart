import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

Future<void> logout() async {
  await FirebaseAuth.instance.signOut();

  // var prefs = await SharedPreferences.getInstance();

  // await prefs.clear();

  Get.offAllNamed('/');

  print('Logged out');
}
