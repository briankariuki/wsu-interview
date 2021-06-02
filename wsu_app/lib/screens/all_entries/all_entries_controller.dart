import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wsu_app/api/entry_api.dart';
import 'package:wsu_app/helpers/helpers.dart';
import 'package:wsu_app/models/models.dart';

class AllEntriesScreenController extends GetxController {
  var isFetching = false.obs;

  EntryApi entryApi = Get.put(EntryApi());

  String q;

  RxList<Entry> entries = RxList.empty();

  EntryPage _entryPage;

  @override
  void onInit() async {
    super.onInit();

    await fetch(true);
  }

  Future<dynamic> fetch(bool refresh) async {
    if (isFetching.isTrue) return;

    isFetching.value = true;

    if (refresh) {
      entries.clear();

      _entryPage = null;
    } else if (_entryPage != null && (_entryPage.page >= _entryPage.pages || _entryPage.docs.length == 0)) {
      isFetching.value = false;
      return;
    }

    try {
      int page = _entryPage == null ? 1 : _entryPage.page + 1;

      var prefs = await SharedPreferences.getInstance();

      var userId = User.fromString(prefs.getString("user")).id;

      Map<String, dynamic> query = {'page': page.toString()};

      if (q != null && q.trim().isNotEmpty) query.addAll({'q': q.trim()});

      _entryPage = (await entryApi.fetch(query)).body.entryPage;

      entries.addAll(_entryPage.docs);

      // _entryPage.docs.forEach((entry) async {
      //   entry.self = userId == entry.user.id;

      //   entries.add(entry);
      // });
    } catch (e) {
      toast(e);
    }
    isFetching.value = false;
  }
}
