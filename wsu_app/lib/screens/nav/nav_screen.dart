import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wsu_app/screens/nav/nav_controller.dart';
import 'package:wsu_app/widgets/responsive_widget.dart';

class NavScreen extends ResponsiveWidget<NavScreenController> {
  @override
  String get tag => 'nav_controller';

  @override
  init() {
    Get.put(NavScreenController(), tag: tag);
  }

  @override
  Widget phone() {
    return Container();
  }
}
