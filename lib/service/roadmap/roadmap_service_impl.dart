import 'package:step_wise/core/utils/typedefs.dart';
import 'package:step_wise/model/roadmap/create_roadmap_request_model.dart';
import 'package:step_wise/service/roadmap/roadmap_service.dart';
import 'package:vexana/vexana.dart';

import '../../core/constants/api_const.dart';
import '../../core/services/network/network_service.dart';
import '../../model/roadmap/roadmap_model.dart';

class RoadmapServiceImpl implements RoadmapService {
  RoadmapServiceImpl({required NetworkService networkService})
      : _networkService = networkService;

  final NetworkService _networkService;

  @override
  ResultFuture<RoadmapModel> getRoadmap() async {
    return _networkService.send<RoadmapModel, RoadmapModel>(
      APIConst.roadmap,
      parseModel: RoadmapModel(),
      method: RequestType.GET,
    );
  }

  @override
  ResultFuture<void> createRoadmap(
      CreateRoadmapRequestModel createRoadmapRequestModel) async {
    return _networkService.send<EmptyModel, EmptyModel>(
      APIConst.roadmap,
      parseModel: EmptyModel(),
      method: RequestType.POST,
      data: createRoadmapRequestModel.toJson(),
    );
  }
}
