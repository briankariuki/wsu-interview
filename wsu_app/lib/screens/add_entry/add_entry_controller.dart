import 'package:get/get.dart';
import 'package:wsu_app/api/entry_api.dart';
import 'package:wsu_app/helpers/helpers.dart';

class AddEntryScreenController extends GetxController {
  var isPosting = false.obs;
  String county = "";
  String subcounty = "";
  String animalsAffected = "";
  String animalsDead = "";
  String peopleAffected = "";
  String peopleDead = "";
  String animalSymptoms = "";
  String humanSymptoms = "";
  RxList<String> animals = RxList.empty();
  RxList<String> exposed = RxList.empty();

  RxList<String> infectWays = RxList([
    "Close contact",
    "Eating meat from dead animals",
    "Eating meat from sick animals",
    "Drinking infected milk from sick animals",
    "Bitten by an animal or insect",
    "Eating contaminated food",
    "Drinking contaminated water",
    "None"
  ]);
  RxList<String> infectAnimals = RxList([
    "Cows",
    "Goats",
    "Sheep",
    "Chicken",
    "Donkeys",
  ]);

  var _entryApi = Get.put(EntryApi());

  void post() async {
    if (isPosting.isTrue) return;

    isPosting.value = true;

    if (check())
      try {
        var formData = {
          'county': county.trim(),
          'subcounty': subcounty.trim(),
          'animalsAffected': int.tryParse(animalsAffected),
          'animalsDead': int.tryParse(animalsDead),
          'animalSymptoms': animalSymptoms.trim(),
          'peopleAffected': int.tryParse(peopleAffected),
          'peopleDead': int.tryParse(peopleDead),
          'humanSymptoms': humanSymptoms.trim(),
          'exposed': exposed,
          'animals': animals,
        };

        await _entryApi.create(formData);

        Get.offAndToNamed('/add-entry/success');
      } catch (e) {
        toast(e);
      }

    isPosting.value = false;
  }

  bool check() {
    try {
      if (county.isEmpty) throw 'Enter county';
      if (subcounty.isEmpty) throw 'Enter subcounty';
      if (animalsAffected.isEmpty) throw 'Enter number of animals affected';
      if (peopleAffected.isEmpty) throw 'Enter number of people affected';
      if (animalsDead.isEmpty) throw 'Enter number of animals dead';
      if (peopleDead.isEmpty) throw 'Enter number of people dead';
      if (animalSymptoms.isEmpty) throw 'Enter animal symptoms';
      if (humanSymptoms.isEmpty) throw 'Enter human symptoms';
      if (animals.isEmpty) throw 'Select one or more animals';
      if (exposed.isEmpty) throw 'Select one or more ways in which people were exposed';

      return true;
    } catch (e) {
      toast(e);

      return false;
    }
  }
}
