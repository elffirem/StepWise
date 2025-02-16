import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_wise/controller/onboarding_controller.dart';
import 'package:step_wise/controller/roadmap_controller.dart';
import 'package:step_wise/core/constants/constants.dart';
import 'package:step_wise/core/extensions/sized_box_extension.dart';
import 'package:step_wise/core/services/local_storage/shared_preferences_manager.dart';
import 'package:step_wise/model/roadmap/roadmap_phase.dart';
import 'package:step_wise/model/roadmap/roadmap_topic.dart';
import 'package:step_wise/ui/components/custom_card.dart';
import 'package:step_wise/ui/components/timeline_painter.dart';
import 'package:step_wise/ui/views/onboarding/onboarding_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/roadmap/roadmap_model.dart';

part 'detailed_roadmap_mixin.dart';

class DetailedRoadmapView extends StatefulWidget {
  final RoadmapModel? roadmapModel;

  const DetailedRoadmapView({super.key, required this.roadmapModel});

  @override
  State<DetailedRoadmapView> createState() => _DetailedRoadmapViewState();
}

class _DetailedRoadmapViewState extends State<DetailedRoadmapView>
    with DetailedRoadmapMixin {
  SharedPreferencesManager manager = SharedPreferencesManager();

  @override
  void initState() {
    super.initState();
    _loadNextLessonAndProgress(); // Progress ve nextLesson yükleniyor
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widget.roadmapModel == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: mPadding, left: lPadding),
                    child: buildList(),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Welcome, ${manager.getString('username')}",
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
              IconButton(
                onPressed: () {
                  final onboardingController = Get.put(OnboardingController());
                  onboardingController.currentPage.value = 0;
                  onboardingController.nameController.clear();
                  onboardingController.professionalBackgroundController.clear();
                  onboardingController.selectedLearningTopic.value = '';

                  manager.remove("token");
                  manager.remove("username");

                  Get.offAll(() => const OnboardingView());
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ),
              )
            ],
          ),
          32.h,
          Text(
            controller.roadmapModel.title ?? "Roadmap",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: sPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(xsPadding),
                        child: Text(
                          "${(controller.progress.value * 100).toInt()}%",
                          style: bodyTextStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => LinearProgressIndicator(
                    minHeight: 12,
                    value: controller.progress.value,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    color: Colors.greenAccent,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Text(
              controller.nextLesson.value.isNotEmpty
                  ? "Next Lesson: ${controller.nextLesson.value}"
                  : "All lessons completed!",
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
          8.h,
        ],
      ),
    );
  }

  Widget buildList() {
    final phases = widget.roadmapModel?.phases;
    if (phases == null) {
      return const SizedBox();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        phases.length,
        (index) {
          var phase = phases[index];
          return buildIndex(index, phase, phases.length);
        },
      ),
    );
  }

  Row buildIndex(int index, RoadmapPhase phase, int totalPhases) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: bigCardSize * 1.45,
          child: CustomPaint(
            painter: TimelinePainter(
              isFirst: index == 0,
              isLast: index == totalPhases - 1,
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  phase.title ?? "${index + 1}th Phase",
                  textAlign: TextAlign.start,
                  style: subheadlineTextStyle.copyWith(color: Colors.black),
                ),
              ),
              CustomCard(
                height: bigCardSize,
                child: FutureBuilder(
                  future: _loadCheckedState(phase.topics!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.separated(
                        itemCount: phase.topics!.length,
                        itemBuilder: (context, index) {
                          return ResourceItem(
                            onCheckedChanged: (bool isChecked) {
                              controller.toggleChecked(phase, index);
                            },
                            isChecked: phase.topics![index].isChecked,
                            title:
                                phase.topics![index].title ?? "No title found",
                            url: phase.topics![index].resources != null &&
                                    phase.topics![index].resources!.isNotEmpty
                                ? phase.topics![index].resources![0].link
                                : null,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(color: Colors.white);
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _loadCheckedState(List<RoadmapTopic> topics) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var topic in topics) {
      bool? isChecked = prefs.getBool(topic.title!);
      if (isChecked != null) {
        topic.isChecked.value = isChecked;
      }
    }
  }

  Future<void> _loadNextLessonAndProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? nextLesson = prefs.getString('nextLesson');
    if (nextLesson != null) {
      controller.nextLesson.value = nextLesson;
    }

    double? progress = prefs.getDouble('progress');
    if (progress != null) {
      controller.progress.value = progress;
    }
  }

  void _updateNextLesson(String lesson) async {
    controller.nextLesson.value = lesson;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nextLesson', lesson);
  }

  void _updateProgress(double progress) async {
    controller.progress.value = progress;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('progress', progress);
  }
}

class ResourceItem extends StatelessWidget {
  final RxBool isChecked;
  final String title;
  final String? url;
  final ValueChanged<bool> onCheckedChanged;

  const ResourceItem({
    super.key,
    required this.isChecked,
    required this.title,
    this.url,
    required this.onCheckedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Checkbox(
              value: isChecked.value,
              onChanged: (bool? value) async {
                if (value != null) {
                  onCheckedChanged(value);

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool(title, value);
                }
              },
            )),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (url != null)
                GestureDetector(
                  onTap: () async {
                    final Uri uri = Uri.parse(url!);
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  },
                  child: const Text(
                    "Suggested resource",
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
