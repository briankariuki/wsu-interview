import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wsu_app/api/entry_api.dart';
import 'package:wsu_app/helpers/helpers.dart';
import 'package:wsu_app/models/models.dart';

class EntryScreenController extends GetxController {
  final String entryId;
  var isFetching = false.obs;

  EntryApi entryApi = Get.put(EntryApi());

  Rx<Entry> entry = Rx(null);

  EntryScreenController({@required this.entryId});

  @override
  void onInit() async {
    super.onInit();

    fetch();
  }

  void fetch() async {
    if (isFetching.isTrue) return;

    isFetching.value = true;

    try {
      entry.value = (await entryApi.fetch({'entryId': entryId})).body.entry;

      var prefs = await SharedPreferences.getInstance();

      var userId = User.fromString(prefs.getString('user')).id;

      if (entry.value != null) entry.value.self = userId == entry.value.user.id;
    } catch (e) {
      toast(e);
    }
    isFetching.value = false;
  }
}
