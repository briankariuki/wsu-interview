import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wsu_app/screens/splash/splash_controller.dart';
import 'package:wsu_app/widgets/responsive_widget.dart';

class SplashScreen extends ResponsiveWidget<SplashController> {
  @override
  String get tag => 'splash_controller';

  @override
  init() {
    Get.put(SplashController(), tag: tag);
  }

  @override
  Widget phone() {
    return Obx(
      () => Scaffold(
        body: Center(
          child: controller.isChecking.isTrue || controller.isOk.isTrue
              ? CircularProgressIndicator()
              : TextButton(
                  onPressed: () => controller.auth(),
                  child: Text('Try again'),
                ),
        ),
      ),
    );
  }
}
