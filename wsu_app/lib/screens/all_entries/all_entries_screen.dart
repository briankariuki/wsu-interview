import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wsu_app/assets.dart';
import 'package:wsu_app/config/palette.dart';
import 'package:wsu_app/screens/all_entries/all_entries_controller.dart';
import 'package:wsu_app/widgets/responsive_widget.dart';
import 'package:wsu_app/widgets/widgets.dart';

class AllEntriesScreen extends ResponsiveWidget<AllEntriesScreenController> {
  @override
  String get tag => 'all_entries_controller';

  @override
  init() {
    Get.put(AllEntriesScreenController(), tag: tag);
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
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) controller.fetch(false);
              return false;
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
                          title: "View Collected \nData",
                          color: Palette.black,
                          lineHeight: 1.4,
                        ),
                        const SizedBox(
                          height: 36.0,
                        ),
                        ParagraphMedium(
                          title: "Search",
                          color: Palette.black3,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextField(
                          cursorColor: Palette.black,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16.0,
                            color: Palette.gray2,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                              vertical: 20.0,
                            ),
                            fillColor: Palette.gray7,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Palette.gray2,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Palette.secondary_red,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                          ),
                          onChanged: (value) {
                            controller.q = value;
                            controller.fetch(true);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => controller.isFetching.value == true
                      ? SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 24.0),
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
                          ),
                        )
                      : (controller.q != null && controller.q.trim().isNotEmpty && controller.entries.length < 1)
                          ? SliverFillRemaining(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 24.0,
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text(
                                        'No Results found',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24.0,
                                  ),
                                  Container(
                                    child: Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller.q = '';
                                          controller.fetch(true);
                                        },
                                        child: Text('Go back'),
                                      ),
                                    ),
                                  )
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
                                          title: "Collected Entries",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
