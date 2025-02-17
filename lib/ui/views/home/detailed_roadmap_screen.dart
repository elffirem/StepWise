import 'package:flutter/material.dart';
import 'package:step_wise/ui/views/home/detailed_roadmap_view.dart';

class DetailedRoadmapScreen extends StatelessWidget {

  const DetailedRoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Step Wise'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Roadmap'),
              Tab(text: 'Quiz'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DetailedRoadmapView(), 
            Center(
              child: Text(
                'Quiz',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
