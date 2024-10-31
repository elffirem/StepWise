import 'package:flutter/material.dart';
import 'package:step_wise/core/constants/constants.dart';
import 'package:step_wise/service/mental_roadmap/mental_roadmap_service_impl.dart';
import 'package:step_wise/ui/components/mood_container.dart';
import 'package:step_wise/ui/views/mental_roadmap/mental_roadmap_view.dart';

part 'mood_selection_mixin.dart';

class MoodSelectionView extends StatefulWidget {
  const MoodSelectionView({super.key});

  @override
  State<MoodSelectionView> createState() => _MoodSelectionViewState();
}

class _MoodSelectionViewState extends State<MoodSelectionView>
    with MoodSelectionMixin {
  MentalRoadmapServiceImpl service = MentalRoadmapServiceImpl();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: mPadding),
            child: Text(
              moodSelectorTitle,
              style: TextStyle(
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: mPadding,
            right: mPadding,
            left: mPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text(
                  moodInstructionText,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Spacer(flex: 1),
              const Text(
                howDoYouFeelToday,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 12,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: mPadding,
                    mainAxisSpacing: mPadding,
                  ),
                  itemCount: moods.length,
                  itemBuilder: (context, index) {
                    return MoodContainer(
                      mood: moods[index]['mood']!,
                      imagePath: moods[index]['imagePath']!,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MentalRoadmapView(
                              mentalRoadmap: service.createMentalRoadmap(
                                  moods[index]['mood'] ?? 'Anxious'),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
