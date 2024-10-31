import '../../core/utils/typedefs.dart';
import '../../model/roadmap/create_roadmap_request_model.dart';
import '../../model/roadmap/roadmap_model.dart';

abstract class RoadmapService {
  ResultFuture<RoadmapModel> getRoadmap();

  ResultFuture<void> createRoadmap(
      CreateRoadmapRequestModel createRoadmapRequestModel);
}
