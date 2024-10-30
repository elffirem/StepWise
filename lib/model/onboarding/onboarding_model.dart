import 'dart:ui';

class OnboardingPageModel {
  final String title;
  final String description;
  final List<String> assetPaths;
  final List<Offset> positions;

  OnboardingPageModel({
    required this.title,
    required this.description,
    required this.assetPaths,
    required this.positions,
  });
}
