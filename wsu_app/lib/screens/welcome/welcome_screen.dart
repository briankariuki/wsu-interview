import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wsu_app/config/palette.dart';
import 'package:wsu_app/screens/welcome/welcome_controller.dart';
import 'package:wsu_app/widgets/responsive_widget.dart';
import 'package:wsu_app/widgets/widgets.dart';

class WelcomeScreen extends ResponsiveWidget<WelcomeController> {
  @override
  String get tag => 'welcome_controller';

  @override
  init() {
    Get.put(WelcomeController(), tag: tag);
  }

  @override
  Widget phone() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Heading3(
              title: "Welcome",
              color: Palette.black,
              lineHeight: 1.4,
            ),
            const SizedBox(
              height: 36.0,
            ),
            const SizedBox(
              height: 32.0,
            ),
            const SizedBox(
              height: 32.0,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: 'Register',
                    color: Palette.black,
                    textColor: Colors.white,
                    height: 60.0,
                    minWidth: 164.0,
                    isLoading: false,
                    onTap: () => Get.offAndToNamed("/register"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
