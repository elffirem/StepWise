import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_wise/core/constants/constants.dart';
import 'package:step_wise/core/enums.dart';
import 'package:step_wise/core/extensions/sized_box_extension.dart';
import 'package:step_wise/ui/components/feature_card.dart';
import 'package:step_wise/ui/views/chat_bot/chat_bot_view.dart'; // Ensure this is the correct path

part 'tools_view_mixin.dart';

class ToolsView extends StatefulWidget {
  const ToolsView({super.key});

  @override
  State<ToolsView> createState() => _ToolsViewState();
}

class _ToolsViewState extends State<ToolsView> with ToolsViewMixin {
  @override
  Widget build(BuildContext context) {
    const TextStyle headlineStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(sPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  preparationHeadline,
                  style: headlineStyle,
                ),
                16.h,
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: sPadding,
                    mainAxisSpacing: sPadding,
                  ),
                  itemCount: preparationFeatures.length,
                  itemBuilder: (context, index) {
                    return FeatureCard(
                      title: preparationFeatures[index]['title']!,
                      subtitle: preparationFeatures[index]['subtitle']!,
                      imagePath: preparationFeatures[index]['imagePath']!,
                      onTap: () {
                        switch (preparationFeatures[index]['title']!) {
                          case 'Interview Prep':
                            Get.to(() => const ChatBotView(
                                  jobApplyTools: JobApplyTools.interviewPrep,
                                ));
                            break;
                          case 'Language Skill':
                            Get.to(() => const ChatBotView(
                                  jobApplyTools: JobApplyTools.languageSkill,
                                ));
                            break;
                          default:
                            Get.to(() => const ChatBotView());
                        }
                      },
                    );
                  },
                ),
                32.h,
                const Text(
                  toolsHeadline,
                  style: headlineStyle,
                ),
                16.h,
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: sPadding,
                    mainAxisSpacing: sPadding,
                  ),
                  itemCount: toolsFeatures.length,
                  itemBuilder: (context, index) {
                    return FeatureCard(
                      title: toolsFeatures[index]['title']!,
                      subtitle: toolsFeatures[index]['subtitle']!,
                      imagePath: toolsFeatures[index]['imagePath']!,
                      onTap: () {
                        switch (toolsFeatures[index]['title']!) {
                          case 'Resume':
                            Get.to(() => const ChatBotView(
                                  jobApplyTools: JobApplyTools.resume,
                                ));
                            break;
                          case 'Cover Letter':
                            Get.to(() => const ChatBotView(
                                  jobApplyTools: JobApplyTools.coverLetter,
                                ));
                            break;
                          case 'Email Response':
                            Get.to(() => const ChatBotView(
                                  jobApplyTools: JobApplyTools.emailResponse,
                                ));
                            break;
                          case 'Write a Caption':
                            Get.to(() => const ChatBotView(
                                  jobApplyTools: JobApplyTools.writeCaption,
                                ));
                            break;
                          default:
                            Get.to(() => const ChatBotView());
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
