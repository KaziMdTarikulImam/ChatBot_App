 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/routes/app_routes.dart';
import 'package:my_app/routes/page_routes.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ChatBot',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash_screen,
      getPages: AppPages.routes,
    );
  }
}