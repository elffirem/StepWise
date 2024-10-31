import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_wise/core/services/local_storage/shared_preferences_manager.dart';
import 'package:step_wise/core/services/network/network_service_impl.dart';
import 'package:step_wise/ui/views/main_scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/init/service_locator/service_locator.dart';
import '../../../../core/services/network/network_service.dart';
import '../../onboarding/onboarding_view.dart';

part 'auth_check_view_mixin.dart';

class AuthCheckView extends StatefulWidget {
  const AuthCheckView({super.key});

  @override
  State<AuthCheckView> createState() => _AuthCheckViewState();
}

class _AuthCheckViewState extends State<AuthCheckView> with AuthCheckViewMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: SizedBox()),
    );
  }
}
