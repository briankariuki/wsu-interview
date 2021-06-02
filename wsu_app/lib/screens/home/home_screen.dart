import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                    ],
                  ),
                ),
              ),
              Obx(
                () => controller.isFetching.value == true
                    ? SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 28,
                              width: 28,
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0,
                              ),
                            ),
                          ],
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                                title: controller.entries.length < 1
                                                    ? "You currently do not have \nany data collected"
                                                    : "You are collecting \ndata",
                                                color: Palette.black2,
                                              ),
                                              const SizedBox(
                                                height: 16.0,
                                              ),
                                              controller.entries.length < 1
                                                  ? CustomButton(
                                                      title: 'Get Started',
                                                      color: Palette.black,
                                                      textColor: Colors.white,
                                                      height: 54.0,
                                                      minWidth: 120.0,
                                                      isLoading: false,
                                                      onTap: () => Get.offAndToNamed("/add-entry"),
                                                    )
                                                  : Subtitle2(
                                                      title: "${controller.entries.length} Data entries",
                                                      color: Palette.black2,
                                                    ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  ParagraphMedium(
                                    title: "My collected Entries",
                                    color: Palette.black3,
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  Container(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (_, index) {
                                        final entry = controller.entries[index];
                                        final dateTime = entry.createdAt.toLocal();
                                        return Container(
                                          padding: EdgeInsets.symmetric(vertical: 8.0),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.black.withOpacity(0.16),
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Subtitle2(
                                                    title: entry.county,
                                                    color: Palette.black3,
                                                  ),
                                                  ParagraphMedium(
                                                    title: DateFormat('EEEE, d MMMM y').format(dateTime),
                                                    color: Palette.black3,
                                                  )
                                                ],
                                              ),
                                              IconButton(
                                                icon: SvgPicture.asset(
                                                  Assets.arrowRight,
                                                  color: Palette.black3,
                                                ),
                                                onPressed: () => Get.toNamed("/entry/${entry.id}"),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount: controller.entries.length,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
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
