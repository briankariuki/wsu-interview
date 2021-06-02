import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wsu_app/assets.dart';
import 'package:wsu_app/config/palette.dart';
import 'package:wsu_app/screens/home/home_controller.dart';
import 'package:wsu_app/widgets/responsive_widget.dart';
import 'package:wsu_app/widgets/widgets.dart';

class HomeScreen extends ResponsiveWidget<HomeScreenController> {
  @override
  String get tag => 'home_controller';

  @override
  init() {
    Get.put(HomeScreenController(), tag: tag);
  }

  @override
  Widget phone() {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.q = '';
            controller.fetch(true);
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 48.0,
                      ),
                      Heading3(
                        title: "My Collected \nData",
                        color: Palette.black,
                        lineHeight: 1.4,
                      ),
                      const SizedBox(
                        height: 36.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                              decoration: BoxDecoration(
                                color: Palette.gray6,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SvgPicture.asset(
                                      Assets.art1,
                                      width: 40.0,
                                      height: 140.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16.0,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ParagraphMedium(
                                        title: "You currently do not have \nany data collected",
                                        color: Palette.black2,
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      CustomButton(
                                        title: 'Get Started',
                                        color: Palette.black,
                                        textColor: Colors.white,
                                        height: 54.0,
                                        minWidth: 120.0,
                                        isLoading: false,
                                        onTap: () => Get.offAndToNamed("/add-entry"),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
