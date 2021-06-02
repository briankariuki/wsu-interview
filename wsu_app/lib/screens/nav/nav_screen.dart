import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wsu_app/assets.dart';
import 'package:wsu_app/config/palette.dart';
import 'package:wsu_app/screens/all_entries/all_entries_screen.dart';
import 'package:wsu_app/screens/home/home_screen.dart';
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
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await controller.navigatorKeys[controller.currentPage.value].currentState.maybePop();

        if (isFirstRouteInCurrentTab) {
          if (controller.currentPage.value != 0) {
            if (0 == controller.currentPage.value) {
              controller.navigatorKeys[0].currentState.popUntil((route) => route.isFirst);
            } else {
              controller.currentPage.value = 0;
            }
            return false;
          }

          return isFirstRouteInCurrentTab;
        }
      },
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.currentPage.value,
            children: [
              HomeScreen(),
              AllEntriesScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentPage.value,
            onTap: (index) {
              controller.currentPage.value = index;
            },
            items: [
              BottomNavigationBarItem(
                icon: Obx(
                  () => SvgPicture.asset(
                    controller.currentPage.value == 0 ? Assets.home2 : Assets.home1,
                    color: controller.currentPage.value == 0 ? Palette.black : Palette.gray3,
                    height: 28.0,
                    width: 28.0,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Obx(
                  () => SvgPicture.asset(
                    controller.currentPage.value == 1 ? Assets.folderSolid : Assets.folder,
                    color: controller.currentPage.value == 1 ? Palette.black : Palette.gray3,
                    height: 28.0,
                    width: 28.0,
                  ),
                ),
                label: '',
              ),
            ],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Palette.black,
            unselectedItemColor: Colors.black54,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
