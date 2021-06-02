import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavScreenController extends GetxController {
  List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  RxInt currentPage = RxInt(0);

  @override
  void onReady() {
    super.onReady();
  }
}
