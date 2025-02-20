import 'package:get/get.dart';
import 'package:step_wise/core/init/service_locator/service_locator.dart';
import 'package:step_wise/core/services/network/network_service.dart';
import 'package:step_wise/model/roadmap/roadmap_phase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/roadmap/roadmap_model.dart';
import '../service/roadmap/roadmap_service_impl.dart'; 

class RoadmapController extends GetxController {
  Rxn<RoadmapModel> roadmapModel = Rxn<RoadmapModel>();
  final RoadmapServiceImpl service =
      RoadmapServiceImpl(networkService: sl<NetworkService>());
  var progress = 0.0.obs;
  var nextLesson = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchRoadmap();
  }

   void _fetchRoadmap() async {
    final result = await service.getRoadmap();
    result.fold(
      (failure) => print('Error: ${failure.toString()}'),// TODO ekranda gösterelim
      (roadmap) {
        roadmapModel.value = roadmap;
        _initialize();
      },
    );
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
    if (roadmapModel.value == null) return;

    final totalItems = roadmapModel.value!.phases!.fold(
      0,
      (previousValue, phase) => previousValue + (phase.topics?.length ?? 0),
    );
    final checkedItems = roadmapModel.value!.phases!.fold(
      0,
      (previousValue, phase) =>
          previousValue +
          (phase.topics?.where((topic) => topic.isChecked.value).length ?? 0),
    );
    progress.value = totalItems == 0 ? 0 : checkedItems / totalItems;
  }

  void _findNextLesson() {
    nextLesson.value = _getNextLesson() ?? '';
  }

  String? _getNextLesson() {
    if (roadmapModel.value == null) return null;
    for (var phase in roadmapModel.value!.phases!) {
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
