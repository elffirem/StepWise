import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_wise/model/roadmap/roadmap_model.dart';
import 'package:step_wise/ui/views/home/detailed_roadmap_view.dart';

class DetailedRoadmapScreen extends StatelessWidget {
  final RoadmapModel roadmapModel;

  const DetailedRoadmapScreen({super.key, required this.roadmapModel});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('step_wise'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Roadmap'),
              Tab(text: 'Quiz'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DetailedRoadmapView(roadmapModel: roadmapModel), // Roadmap sekmesi
            const Center(
              child: Text(
                'Quiz',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ), // Quiz sekmesi
          ],
        ),
      ),
    );
  }
}
