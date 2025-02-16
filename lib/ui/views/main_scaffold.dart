import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_wise/controller/navigation_controller.dart';
import 'package:step_wise/core/constants/constants.dart';
import 'package:step_wise/service/roadmap/roadmap_service_impl.dart';
import 'package:step_wise/ui/views/chat_bot/chat_bot_view.dart';
import 'package:step_wise/ui/views/home/detailed_roadmap_view.dart';
import 'package:step_wise/ui/views/mental_roadmap/mood_selection/mood_selection_view.dart';
import 'package:step_wise/ui/views/tools/tools_view.dart';

import '../../core/init/service_locator/service_locator.dart';
import '../../core/services/network/network_service.dart';
import '../../model/roadmap/roadmap_model.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({Key? key}) : super(key: key);

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  final PageController _pageController = PageController();
  final RoadmapServiceImpl service =
      RoadmapServiceImpl(networkService: sl<NetworkService>());
  RoadmapModel? _roadmapModel;

  @override
  void initState() {
    super.initState();
    _fetchRoadmap();
  }

  void _fetchRoadmap() async {
    final result = await service.getRoadmap();
    result.fold(
      (failure) => print('Error: ${failure.toString()}'),
      (roadmap) {
        setState(() {
          _roadmapModel = roadmap;
        });
      },
    );
  }

  void _onPageChanged(int index) {
    Get.find<NavigationController>().updateIndex(index);
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
    Get.find<NavigationController>().updateIndex(index);
  }

  Icon _getIcon(
      int index, int currentIndex, IconData filledIcon, IconData outlinedIcon) {
    return Icon(
      currentIndex == index ? filledIcon : outlinedIcon,
      color: primaryColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          DetailedRoadmapView(roadmapModel: _roadmapModel),
          const ChatBotView(),
          const ToolsView(),
          const MoodSelectionView(),
        ],
      ),
      bottomNavigationBar: Obx(
        () {
          final currentIndex =
              Get.find<NavigationController>().currentIndex.value;
          return BottomNavigationBar(
            backgroundColor: backgroundColor,
            elevation: 0,
            currentIndex: currentIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon:
                    _getIcon(currentIndex, 0, Icons.home, Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _getIcon(currentIndex, 1, Icons.chat_bubble,
                    Icons.chat_bubble_outline),
                label: 'Chatbot',
              ),
              BottomNavigationBarItem(
                icon: _getIcon(currentIndex, 2, Icons.grid_view_rounded,
                    Icons.grid_view_outlined),
                label: 'Apply tools',
              ),
              BottomNavigationBarItem(
                icon: _getIcon(
                    currentIndex, 3, Icons.favorite, Icons.favorite_border),
                label: 'Mental Roadmap',
              ),
            ],
            selectedItemColor: primaryColor,
            unselectedItemColor: primaryColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
          );
        },
      ),
    );
  }
}
