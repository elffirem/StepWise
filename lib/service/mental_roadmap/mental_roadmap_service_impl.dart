import 'package:net_kit/net_kit.dart';
import 'package:step_wise/core/services/network/network_service.dart';
import 'package:step_wise/core/utils/typedefs.dart';

import '../../core/constants/api_const.dart';
import '../../core/init/service_locator/service_locator.dart';
import '../../model/mental_roadmap/mental_roadmap_model.dart';
import 'mental_roadmap_service.dart';

class MentalRoadmapServiceImpl implements MentalRoadmapService {
  final NetworkService _networkService = sl<NetworkService>();

  @override
  ResultFuture<List<MentalRoadmapModel>> createMentalRoadmap(String mood) {
    return _networkService.requestList<MentalRoadmapModel>(
      '${APIConst.mentalRoadmap}/$mood',
      parseModel: MentalRoadmapModel(),
      method: RequestMethod.post,
    );
  }

  @override
  ResultFuture<List<MentalRoadmapModel>> getMentalRoadmap() {
    return _networkService.requestList<MentalRoadmapModel>(
      APIConst.mentalRoadmap,
      parseModel: MentalRoadmapModel(),
      method: RequestMethod.get,
    );
  }
}
