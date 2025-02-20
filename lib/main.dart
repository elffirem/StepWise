import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_wise/controller/focus_mode_controller.dart';
import 'package:step_wise/controller/task_controller.dart';

import 'controller/navigation_controller.dart';
import 'core/constants/constants.dart';
import 'core/init/service_locator/service_locator.dart';
import 'ui/views/authentications/auth_check/auth_check_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 2) Binding'i başlat
  await GetStorage.init();

  HttpOverrides.global = MyHttpOverrides();
  await ServiceLocator.instance.init();
  Get.put(NavigationController());
  Get.put(TaskController());
  Get.put(FocusModeController());

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
        home: const AuthCheckView()
        // home: const TodoView()
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
