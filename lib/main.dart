import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller/navigation_controller.dart';
import 'core/constants/constants.dart';
import 'core/init/service_locator/service_locator.dart';
import 'ui/views/authentications/auth_check/auth_check_view.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  await ServiceLocator.instance.init();
  Get.put(NavigationController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: primaryColor,
          textTheme: GoogleFonts.soraTextTheme(),
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(color: backgroundColor)),
      home: const AuthCheckView(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (_, __, ___) => true;
  }
}