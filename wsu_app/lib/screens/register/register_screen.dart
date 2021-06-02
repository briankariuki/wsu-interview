import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wsu_app/screens/register/register_controller.dart';
import 'package:wsu_app/widgets/responsive_widget.dart';

class RegisterScreen extends ResponsiveWidget<RegisterScreenController> {
  @override
  String get tag => 'register_controller';

  @override
  init() {
    Get.put(RegisterScreenController(), tag: tag);
  }

  @override
  Widget phone() {
    return Container();
  }
}
