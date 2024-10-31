import 'package:step_wise/model/mental_roadmap/mental_roadmap_model.dart';

import '../../core/utils/typedefs.dart';

abstract class MentalRoadmapService {
  ResultFuture<List<MentalRoadmapModel>> getMentalRoadmap();

  ResultFuture<List<MentalRoadmapModel>> createMentalRoadmap(String mood);
}
