// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:step_wise/core/constants/constants.dart';
// import 'package:step_wise/core/extensions/sized_box_extension.dart';
// import 'package:step_wise/model/card_model.dart';
// import 'package:step_wise/model/roadmap/roadmap_phase.dart';
// import 'package:step_wise/ui/components/custom_button.dart';
// import 'package:step_wise/ui/components/custom_card.dart';
// import 'package:step_wise/ui/components/timeline_painter.dart';
// import 'package:step_wise/ui/views/main_scaffold.dart';

// import '../../../model/roadmap/roadmap_model.dart';

// class OldTimelineView extends StatefulWidget {
//   final RoadmapModel roadmapModel;

//   const OldTimelineView({super.key, required this.roadmapModel});

//   @override
//   _TimelineViewState createState() => _TimelineViewState();
// }

// class _TimelineViewState extends State<OldTimelineView> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Padding(
//           padding: const EdgeInsets.only(right: mPadding, left: lPadding),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(
//                   top: MediaQuery.of(context).padding.top + mPadding,
//                   bottom: sPadding,
//                 ),
//                 child: Text(
//                   "Here is your roadmap 🚀",
//                   style: headlineTextStyle.copyWith(fontSize: 26),
//                 ),
//               ),
//               20.h,
//               Text(
//                 widget.roadmapModel.title ?? '',
//                 style: subheadlineTextStyle,
//                 maxLines: 4,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               20.h,
//               Expanded(
//                 child: buildList(),
//               ),
//               Center(
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.only(top: mPadding, bottom: xxlPadding),
//                   child: CustomButton(
//                     height: 40,
//                     width: 140,
//                     title: continueButtonText,
//                     onTap: () {
//                       Get.to(
//                         () => const MainScaffold(),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildList() {
//     var phases = widget.roadmapModel.phases ?? [];
//     return ListView.builder(
//       itemCount: phases.length,
//       itemBuilder: (context, index) {
//         var phase = phases[index];
//         return buildIndex(index, phase, phases.length);
//       },
//     );
//   }

//   Widget buildIndex(int index, RoadmapPhase phase, int totalPhases) {
//     final CardModel model = CardModel(
//       imagePath: phase.imageUrl ?? 'assets/images/deep_learning.png',
//       title: phase.title ?? 'No Title',
//       subtitle: phase.duration ?? 'No Duration',
//     );

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: smallPlusCardSize + 20,
//           child: CustomPaint(
//             painter: TimelinePainter(
//               isFirst: index == 0,
//               isLast: index == totalPhases - 1,
//             ),
//           ),
//         ),
//         const SizedBox(width: 24),
//         Expanded(
//           child: CustomCard(
//             height: smallPlusCardSize,
//             child: Row(
//               children: <Widget>[
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: phase.imageUrl != null
//                       ? Image.network(phase.imageUrl!)
//                       : Image.asset(
//                           model.imagePath,
//                         ),
//                 ),
//                 const SizedBox(width: 20),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                          model.title.replaceAll(RegExp(r'\(.*\)$'), ''),
//                           style: subheadlineTextStyle.copyWith(fontSize: 14),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           "Duration: ${model.subtitle}",
//                           style: captionTextStyle.copyWith(fontSize: 14, color: Colors.black54),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
