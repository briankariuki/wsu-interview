import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wsu_app/assets.dart';
import 'package:wsu_app/config/palette.dart';
import 'package:wsu_app/screens/entry/entry_controller.dart';
import 'package:wsu_app/widgets/responsive_widget.dart';
import 'package:wsu_app/widgets/widgets.dart';

class EntryScreen extends ResponsiveWidget<EntryScreenController> {
  @override
  String get tag => 'entry_controller';

  @override
  init() {
    Get.put(EntryScreenController(entryId: Get.parameters['entryId']), tag: tag);
  }

  @override
  Widget phone() {
    final formatter = new NumberFormat("#,###");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(
            Assets.arrowLeft,
            height: 28.0,
            width: 28.0,
            color: Palette.black,
          ),
        ),
        title: Subtitle(
          title: "Entry",
          color: Palette.black,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetch();
        },
        child: CustomScrollView(
          slivers: [
            Obx(
              () => controller.isFetching.value == true
                  ? SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
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
                  : SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 16.0,
                        ),
                        child: Column(
                          children: [
                            EntryInfo(
                              title: controller.entry.value.county,
                              value: "County",
                            ),
                            EntryInfo(
                              title: controller.entry.value.subcounty,
                              value: "Subcounty",
                            ),
                            EntryInfo(
                              title: controller.entry.value.animals.join(", "),
                              value: "Animals Affected",
                            ),
                            EntryInfo(
                              title: formatter.format(controller.entry.value.animalsAffected),
                              value: "Number of Animals Affected",
                            ),
                            EntryInfo(
                              title: formatter.format(controller.entry.value.animalsDead),
                              value: "Number of Animals Dead",
                            ),
                            EntryInfo(
                              title: controller.entry.value.animalSymptoms,
                              value: "Symptoms animals showed",
                            ),
                            EntryInfo(
                              title: formatter.format(controller.entry.value.peopleAffected),
                              value: "Number of People Affected",
                            ),
                            EntryInfo(
                              title: formatter.format(controller.entry.value.peopleDead),
                              value: "Number of People Dead",
                            ),
                            EntryInfo(
                              title: controller.entry.value.humanSymptoms,
                              value: "Symptoms people showed",
                            ),
                            EntryInfo(
                              title: controller.entry.value.exposed.join(", "),
                              value: "How people were exposed",
                            )
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class EntryInfo extends StatelessWidget {
  final String value;
  final String title;

  const EntryInfo({
    Key key,
    @required this.value,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              ParagraphMedium(
                title: title,
                color: Palette.black3,
                fontSize: 15.0,
              ),
              Small(
                title: value,
                color: Palette.gray2,
              )
            ],
          ),
        ],
      ),
    );
  }
}
