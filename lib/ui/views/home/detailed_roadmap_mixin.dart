part of 'detailed_roadmap_view.dart';

mixin DetailedRoadmapMixin on State<DetailedRoadmapView> {
  late final RoadmapController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(RoadmapController(widget.roadmapModel));
  }

  @override
  void dispose() {
    Get.delete<RoadmapController>();
    super.dispose();
  }
}
