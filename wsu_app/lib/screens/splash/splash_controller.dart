import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wsu_app/api/auth_api.dart';
import 'package:wsu_app/helpers/helpers.dart';

class SplashController extends GetxController {
  var isChecking = false.obs;
  var isOk = true.obs;

  @override
  void onReady() {
    super.onReady();

    auth();
  }

  void auth() async {
    isChecking.value = true;

    if (FirebaseAuth.instance.currentUser == null)
      Get.offAndToNamed('/welcome');
    else {
      try {
        BaseResponse response = (await Get.put(AuthApi()).auth()).body;

        var prefs = await SharedPreferences.getInstance();

        await prefs.setString('user', response.user.toString());

        Get.offAllNamed('/');

        isOk.value = true;
      } catch (e) {
        if (e.toString().toLowerCase().endsWith('user not found')) {
          Get.offAllNamed('/register');

          isOk.value = true;
        } else {
          toast(e);
          isOk.value = false;
        }
      }
    }

    isChecking.value = false;
  }
}
