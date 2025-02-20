import 'package:flutter/material.dart';
import 'package:step_wise/ui/components/city_map_section.dart';
import 'package:step_wise/ui/components/time_control_section.dart';
import 'package:step_wise/ui/components/user_status_section.dart';

class FocusModeView extends StatelessWidget {
  const FocusModeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Degrade arka plan
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB3E5FC), // Hafif mavi
              Color(0xFFE1F5FE), // Daha açık mavi
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const SafeArea(
          child: Column(
            children: [
              UserStatusSection(),
              Expanded(child: CityMapSection()),
              TimeControlSection(),
            ],
          ),
        ),
      ),
    );
  }
}
