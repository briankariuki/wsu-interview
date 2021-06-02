import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wsu_app/assets.dart';
import 'package:wsu_app/config/palette.dart';
import 'package:wsu_app/screens/add_entry/add_entry_controller.dart';
import 'package:wsu_app/widgets/global_widgets/typography.dart';
import 'package:wsu_app/widgets/responsive_widget.dart';
import 'package:wsu_app/widgets/widgets.dart';

class AddEntryScreen extends ResponsiveWidget<AddEntryScreenController> {
  @override
  String get tag => 'add_entry_controller';

  @override
  init() {
    Get.put(AddEntryScreenController(), tag: tag);
  }

  @override
  Widget phone() {
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
          title: "Add Entry",
          color: Palette.black,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ParagraphMedium(
                            title: "County",
                            color: Palette.black3,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          MyTextField(
                            onChanged: (value) {
                              controller.county = value;
                            },
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ParagraphMedium(
                            title: "Sub-County",
                            color: Palette.black3,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          MyTextField(
                            onChanged: (value) {
                              controller.subcounty = value;
                            },
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ParagraphMedium(
                            title: "Animals Affected",
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
                                final item = controller.infectAnimals[index];

                                return Obx(
                                  () {
                                    final index2 = controller.animals.indexWhere((e) => e == item);

                                    final showDot = index2 == -1 ? false : true;
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: Palette.gray7,
                                            borderRadius: BorderRadius.circular(6.0),
                                          ),
                                          child: ListTile(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(6.0),
                                            ),
                                            leading: Container(
                                              height: 24.0,
                                              width: 24.0,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30.0),
                                                border: Border.all(
                                                  color: Palette.black,
                                                  width: 2.0,
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: showDot
                                                  ? CircleAvatar(
                                                      radius: 6.0,
                                                      backgroundColor: Palette.black,
                                                    )
                                                  : const SizedBox.shrink(),
                                            ),
                                            title: ParagraphMedium(title: item, color: Palette.black),
                                            onTap: showDot
                                                ? () {
                                                    controller.animals.remove(item);
                                                  }
                                                : () {
                                                    controller.animals.add(item);
                                                  },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              itemCount: controller.infectAnimals.length,
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ParagraphMedium(
                            title: "Number of Animals Affected",
                            color: Palette.black3,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          MyTextField(
                            isNumerickeyboard: true,
                            onChanged: (value) {
                              controller.animalsAffected = value;
                            },
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ParagraphMedium(
                            title: "Number of Animals Dead",
                            color: Palette.black3,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          MyTextField(
                            isNumerickeyboard: true,
                            onChanged: (value) {
                              controller.animalsDead = value;
                            },
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ParagraphMedium(
                            title: "Symptoms animals showed",
                            color: Palette.black3,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          MyTextField(
                            isMultiline: true,
                            onChanged: (value) {
                              controller.animalSymptoms = value;
                            },
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ParagraphMedium(
                            title: "Number of People Affected",
                            color: Palette.black3,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          MyTextField(
                            isNumerickeyboard: true,
                            onChanged: (value) {
                              controller.peopleAffected = value;
                            },
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ParagraphMedium(
                            title: "Number of People Dead",
                            color: Palette.black3,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          MyTextField(
                            isNumerickeyboard: true,
                            onChanged: (value) {
                              controller.peopleDead = value;
                            },
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ParagraphMedium(
                            title: "Symptoms sick people showed",
                            color: Palette.black3,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          MyTextField(
                            isMultiline: true,
                            onChanged: (value) {
                              controller.humanSymptoms = value;
                            },
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ParagraphMedium(
                            title: "How the people were exposed",
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
                                final item = controller.infectWays[index];

                                return Obx(
                                  () {
                                    final index2 = controller.exposed.indexWhere((e) => e == item);

                                    final showDot = index2 == -1 ? false : true;
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: Palette.gray7,
                                            borderRadius: BorderRadius.circular(6.0),
                                          ),
                                          child: ListTile(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(6.0),
                                            ),
                                            leading: Container(
                                              height: 24.0,
                                              width: 24.0,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30.0),
                                                border: Border.all(
                                                  color: Palette.black,
                                                  width: 2.0,
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: showDot
                                                  ? CircleAvatar(
                                                      radius: 6.0,
                                                      backgroundColor: Palette.black,
                                                    )
                                                  : const SizedBox.shrink(),
                                            ),
                                            title: ParagraphMedium(title: item, color: Palette.black),
                                            onTap: showDot
                                                ? () {
                                                    controller.exposed.remove(item);
                                                  }
                                                : () {
                                                    controller.exposed.add(item);
                                                  },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              itemCount: controller.infectWays.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Obx(
                      () => CustomButton(
                        title: 'Add',
                        color: Palette.black,
                        textColor: Colors.white,
                        height: 60.0,
                        minWidth: 164.0,
                        isLoading: controller.isPosting.value,
                        onTap: controller.isPosting.value == true ? () {} : () => controller.post(),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final Function(String value) onChanged;
  final bool isNumerickeyboard;
  final bool isMultiline;

  const MyTextField({
    Key key,
    this.onChanged,
    this.isNumerickeyboard = false,
    this.isMultiline = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Palette.black,
      minLines: isMultiline ? 6 : 1,
      maxLines: isMultiline ? 6 : 1,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 16.0,
        color: Palette.gray2,
        fontWeight: FontWeight.w500,
      ),
      keyboardType: isNumerickeyboard ? TextInputType.number : TextInputType.text,
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
      onChanged: onChanged,
    );
  }
}
