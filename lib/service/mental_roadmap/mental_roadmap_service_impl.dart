import 'package:step_wise/core/services/network/network_service.dart';
import 'package:step_wise/core/utils/typedefs.dart';
import 'package:vexana/vexana.dart';

import '../../core/constants/api_const.dart';
import '../../core/init/service_locator/service_locator.dart';
import '../../model/mental_roadmap/mental_roadmap_model.dart';
import 'mental_roadmap_service.dart';

class MentalRoadmapServiceImpl implements MentalRoadmapService {
  final NetworkService _networkService = sl<NetworkService>();

  @override
  ResultFuture<List<MentalRoadmapModel>> createMentalRoadmap(String mood) {
    return _networkService.send<MentalRoadmapModel, List<MentalRoadmapModel>>(
      '${APIConst.mentalRoadmap}/$mood',
      parseModel: MentalRoadmapModel(),
      method: RequestType.POST,
    );
  }

  @override
  ResultFuture<List<MentalRoadmapModel>> getMentalRoadmap() {
    return _networkService.send<MentalRoadmapModel, List<MentalRoadmapModel>>(
      APIConst.mentalRoadmap,
      parseModel: MentalRoadmapModel(),
      method: RequestType.GET,
    );
  }
}
