import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:wsu_app/config/theme.dart';
import 'package:wsu_app/helpers/helpers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license1 = await rootBundle.loadString('assets/fonts/Inter OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license1);

    final license2 = await rootBundle.loadString('assets/fonts/Poppins OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license2);
  });

  await DotEnv.load();

  await Firebase.initializeApp();

  runZonedGuarded(() {
    runApp(
      MyApp(),
    );
  }, (error, stackTrace) {
    print('runZonedGuarded: Caught error in my root zone.');
    print(error);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/splash',
      getPages: kRoutes,
      theme: AppTheme.lightThemeData(context),
      debugShowCheckedModeBanner: false,
    );
  }
}
