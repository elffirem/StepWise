import 'package:get/get.dart';
import 'package:step_wise/model/roadmap/roadmap_phase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/roadmap/roadmap_model.dart';

class RoadmapController extends GetxController {
  final RoadmapModel roadmapModel;
  
  var progress = 0.0.obs;
  var nextLesson = ''.obs;

  RoadmapController(this.roadmapModel) {
    _initialize();
  }

  void _initialize() async {
    await _loadProgressAndNextLesson(); 
    _calculateProgress();
    _findNextLesson();
  }

  void toggleChecked(RoadmapPhase phase, int topicIndex) async {
    var topic = phase.topics![topicIndex];
    topic.isChecked.value = !topic.isChecked.value;
    _calculateProgress();
    _findNextLesson();
    await _saveProgressAndNextLesson(); 
  }

  void _calculateProgress() {
    final totalItems = roadmapModel.phases!.fold(0,
        (previousValue, phase) => previousValue + (phase.topics?.length ?? 0));
    final checkedItems = roadmapModel.phases!.fold(
        0,
        (previousValue, phase) =>
            previousValue +
            (phase.topics?.where((topic) => topic.isChecked.value).length ?? 0));
    progress.value = totalItems == 0 ? 0 : checkedItems / totalItems;
  }

  void _findNextLesson() {
    nextLesson.value = _getNextLesson() ?? '';
  }

  String? _getNextLesson() {
    for (var phase in roadmapModel.phases!) {
      for (var topic in phase.topics!) {
        if (!topic.isChecked.value) {
          return topic.title;
        }
      }
    }
    return null;
  }

  Future<void> _saveProgressAndNextLesson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('progress', progress.value);
    prefs.setString('nextLesson', nextLesson.value);
  }

  Future<void> _loadProgressAndNextLesson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    progress.value = prefs.getDouble('progress') ?? 0.0;
    nextLesson.value = prefs.getString('nextLesson') ?? '';
  }
}
