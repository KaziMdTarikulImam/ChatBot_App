import 'package:get/get.dart';
import 'package:my_app/routes/app_routes.dart';
import 'package:my_app/widgets/auth/login.dart';
import 'package:my_app/widgets/auth/registration.dart';
import 'package:my_app/widgets/home/chat.dart';
import 'package:my_app/widgets/home/home.dart';
import 'package:my_app/widgets/splash_screen/splash_screen.dart';
class AppPages {
  static final routes = [
    // Define your page routes here
    // Example:
    //Auth Routes
     GetPage(name: AppRoutes.splash_screen, page: () => splash_screen()),
     GetPage(name: AppRoutes.registration, page: () => registration()),
     GetPage(name: AppRoutes.login, page: () => login()),

    // Home Route
     GetPage(name: AppRoutes.home, page: () => home()),
     GetPage(name: AppRoutes.chat, page: () => chat()), // Replace with actual chat page
    // GetPage(name: AppRoutes.settings, page: () => SettingsPage()),
  ];
  
}