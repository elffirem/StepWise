import 'package:net_kit/net_kit.dart';
import 'package:step_wise/core/utils/typedefs.dart';
import 'package:step_wise/model/roadmap/create_roadmap_request_model.dart';
import 'package:step_wise/service/roadmap/roadmap_service.dart';

import '../../core/constants/api_const.dart';
import '../../core/services/network/network_service.dart';
import '../../model/roadmap/roadmap_model.dart';

class RoadmapServiceImpl implements RoadmapService {
  RoadmapServiceImpl({required NetworkService networkService})
      : _networkService = networkService;

  final NetworkService _networkService;

  @override
  ResultFuture<RoadmapModel> getRoadmap() async {
    return _networkService.requestModel<RoadmapModel>(
      APIConst.roadmap,
      parseModel: RoadmapModel(),
      method: RequestMethod.get,
    );
  }

  @override
  ResultFuture<void> createRoadmap(
      CreateRoadmapRequestModel createRoadmapRequestModel) async {
    return _networkService.requestVoid(
      APIConst.roadmap,
      method: RequestMethod.post,
      body: createRoadmapRequestModel.toJson(),
    );
  }
}
