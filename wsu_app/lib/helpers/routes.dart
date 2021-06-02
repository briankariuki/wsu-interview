import 'package:get/get.dart';
import 'package:wsu_app/screens/add_entry/add_entry_screen.dart';
import 'package:wsu_app/screens/add_entry/add_entry_success.dart';
import 'package:wsu_app/screens/login/login_screen.dart';
import 'package:wsu_app/screens/nav/nav_screen.dart';
import 'package:wsu_app/screens/register/register_screen.dart';
import 'package:wsu_app/screens/splash/splash_screen.dart';
import 'package:wsu_app/screens/welcome/welcome_screen.dart';

final kRoutes = [
  GetPage(
    name: '/',
    page: () => NavScreen(),
    children: [],
  ),
  GetPage(
    name: '/welcome',
    page: () => WelcomeScreen(),
    children: [],
  ),
  GetPage(
    name: '/splash',
    page: () => SplashScreen(),
  ),
  GetPage(
    name: '/register',
    page: () => RegisterScreen(),
    children: [],
  ),
  GetPage(
    name: '/login',
    page: () => LoginScreen(),
    children: [],
  ),
  GetPage(
    name: '/add-entry',
    page: () => AddEntryScreen(),
    children: [
      GetPage(
        name: '/success',
        page: () => AddEntrySuccessWidget(),
      ),
    ],
  ),
];
