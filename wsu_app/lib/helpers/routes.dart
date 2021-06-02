import 'package:get/get.dart';
import 'package:wsu_app/screens/login/login_screen.dart';
import 'package:wsu_app/screens/nav/nav_screen.dart';
import 'package:wsu_app/screens/register/register_screen.dart';
import 'package:wsu_app/screens/splash/splash_screen.dart';

final kRoutes = [
  GetPage(
    name: '/',
    page: () => NavScreen(),
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
];
