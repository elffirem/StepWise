import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart'; // Make sure to import the Either type
import 'package:lottie/lottie.dart';
import 'package:step_wise/core/constants/constants.dart';
import 'package:step_wise/core/errors/failures/failure.dart';
import 'package:step_wise/core/extensions/sized_box_extension.dart';
import 'package:step_wise/core/utils/typedefs.dart';
import 'package:step_wise/model/mental_roadmap/mental_roadmap_model.dart';
import 'package:step_wise/ui/components/custom_card.dart';
import 'package:step_wise/ui/components/timeline_painter.dart';

class MentalRoadmapView extends StatelessWidget {
  final ResultFuture<List<MentalRoadmapModel>> mentalRoadmap;

  const MentalRoadmapView({super.key, required this.mentalRoadmap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(mPadding),
            child: FutureBuilder<Either<Failure, List<MentalRoadmapModel>>>(
              future: mentalRoadmap,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Lottie.asset(
                      "assets/animations/witch.json",
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final result = snapshot.data!;
                  return result.fold(
                    (failure) => Text('Error: ${failure.message}'),
                    (mentalRoadmap) => buildContent(mentalRoadmap),
                  );
                } else {
                  return const Text('No data available');
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContent(List<MentalRoadmapModel> mentalRoadmap) {
    final firstMood = mentalRoadmap.isNotEmpty && mentalRoadmap.first.mood != null
        ? mentalRoadmap.first.mood!
        : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
  
      children: [
        20.h,
        buildHeadline(firstMood),
        20.h,
        buildTimeline(mentalRoadmap),
      ],
    );
  }

  RichText buildHeadline(String firstMood) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: [
          const TextSpan(text: 'Mental Roadmap'),
          if (firstMood.isNotEmpty) ...[
            const TextSpan(text: ' for '),
            TextSpan(
              text: firstMood,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: primaryColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildTimeline(List<MentalRoadmapModel> mentalRoadmap) {
    return Column(
      children: List.generate(
        mentalRoadmap.length,
        (index) => buildPhase(mentalRoadmap[index], index, mentalRoadmap.length),
      ),
    );
  }

  Widget buildPhase(MentalRoadmapModel phase, int index, int totalPhases) {
    final List<String> images = [
      'assets/images/morning.png',
      'assets/images/midday.png',
      'assets/images/evening.png',
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: mediumPlusCardSize + 20,
          child: CustomPaint(
            painter: TimelinePainter(
              isFirst: index == 0,
              isLast: index == totalPhases - 1,
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: CustomCard(
            height: mediumPlusCardSize,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      images[index % images.length], 
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                15.w,
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          phase.time ?? 'Unknown Time',
                          style: subheadlineTextStyle.copyWith(fontSize: 14, color: primaryColor),
                        ),
                        4.h,
                        Text(
                          phase.title ?? 'No Title',
                          style: headlineTextStyle.copyWith(fontSize: 16),
                        ),
                        4.h,
                        Text(
                          phase.description ?? 'No Description',
                          style: captionTextStyle.copyWith(fontSize: 14, color: Colors.black54),
                        ),
              
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
