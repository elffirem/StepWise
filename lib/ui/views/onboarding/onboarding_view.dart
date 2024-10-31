import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_wise/controller/onboarding_controller.dart';
import 'package:step_wise/core/constants/constants.dart';
import 'package:step_wise/core/extensions/sized_box_extension.dart';
import 'package:step_wise/model/auth/sign_up_request_model.dart';
import 'package:step_wise/model/card_model.dart';
import 'package:step_wise/model/onboarding/onboarding_model.dart';
import 'package:step_wise/model/roadmap/create_roadmap_request_model.dart';
import 'package:step_wise/ui/components/custom_button.dart';
import 'package:step_wise/ui/components/custom_card.dart';
import 'package:step_wise/ui/views/authentications/sign_in_view.dart';
import 'package:step_wise/ui/views/authentications/sign_up_view.dart';

part 'onboarding_mixin.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> with OnboardingMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Obx(() {
          var page = onboardingController
              .onboardingPages[onboardingController.currentPage.value];
          return Stack(
            children: [
              bgImage(),
              bgBlur(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: mPadding),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: context.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment:
                                onboardingController.currentPage.value < 3
                                    ? CrossAxisAlignment.center
                                    : CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (onboardingController.currentPage.value < 3)
                                ...firstPartOnboarding(page)
                              else
                                ...secondPartOnboarding(page),
                              if (onboardingController.currentPage.value == 3)
                                ...nameInput(page),
                              if (onboardingController.currentPage.value == 4)
                                aimInput(page),
                              if (onboardingController.currentPage.value == 5)
                                professionalBackgroundInput(),
                              if (onboardingController.currentPage.value == 6)
                                learningDepartmentInput(),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      onboardingController
                                          .onboardingPages.length,
                                      (index) => Obx(() {
                                        return Column(
                                          children: [
                                            Visibility(
                                              replacement: const SizedBox(
                                                width: 10,
                                                height: 50,
                                              ),
                                              visible: onboardingController
                                                          .currentPage.value ==
                                                      index &&
                                                  onboardingController
                                                          .currentPage.value >=
                                                      3,
                                              child: Image.asset(
                                                'assets/images/onboard/bunny.png',
                                                width: 50,
                                                height: 50,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Icon(
                                                      Icons.error);
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              height:
                                                  4.0, // padding between asset and dot
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              width: 10.0,
                                              height: 10.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: onboardingController
                                                            .currentPage
                                                            .value ==
                                                        index
                                                    ? Colors.black
                                                    : Colors.black
                                                        .withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                              30.h,
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: GestureDetector(
                                  onTap: () {
                                    if (onboardingController
                                            .currentPage.value ==
                                        6) {
                                      Get.to(
                                        () => SignUpView(
                                          createRoadmapRequestModel:
                                              CreateRoadmapRequestModel(
                                            goal: onboardingController
                                                .selectedLearningTopic.value,
                                            professionalBackground:
                                                onboardingController
                                                    .professionalBackgroundController
                                                    .text,
                                          ),
                                          signUpRequestModel:
                                              SignUpRequestModel(
                                            fullName: onboardingController
                                                .nameController.text,
                                            purpose:
                                                onboardingController.goal.value,
                                          ),
                                        ),
                                      );
                                    } else {
                                      onboardingController.nextPage();
                                    }
                                  },
                                  child: const CustomButton(
                                    height: 40,
                                    width: 120,
                                    title: nextButtonText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              buildBackButton(),
            ],
          );
        }),
      ),
    );
  }

  Widget buildBackButton() {
    return Positioned(
      top: 40,
      left: 16,
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: primaryColor),
        onPressed: previousPage,
      ),
    );
  }

  List<Widget> secondPartOnboarding(OnboardingPageModel page) {
    return [
      100.h,
      Text(
        page.title,
        style: headlineTextStyle,
        textAlign: TextAlign.start,
      ),
      Text(
        page.description,
        style: headlineTextStyle,
        textAlign: TextAlign.left,
      ),
    ];
  }

  List<Widget> firstPartOnboarding(OnboardingPageModel page) {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Text(
          page.title,
          style: GoogleFonts.caladea(
            fontSize: 55,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ),
      Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: headlineTextStyle,
            children: [
              TextSpan(
                text: '${page.description.split(' ')[0]} ',
                style: headlineTextStyle.copyWith(fontSize: 15),
              ),
              TextSpan(
                text: page.description.split(' ')[1],
                style: headlineTextStyle.copyWith(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: Stack(
          children: List.generate(page.assetPaths.length, (index) {
            double width;
            double height;

            if (page.assetPaths[index].contains('road')) {
              width = MediaQuery.of(context).size.width * 0.75;
              height = MediaQuery.of(context).size.height * 0.8;
            } else if (page.assetPaths[index].contains('bunny') && index != 0) {
              width = MediaQuery.of(context).size.width * 0.25;
              height = MediaQuery.of(context).size.height * 0.25;
            } else {
              width = 130;
              height = 130;
            }

            return Positioned(
              left:
                  MediaQuery.of(context).size.width * page.positions[index].dx,
              top:
                  MediaQuery.of(context).size.height * page.positions[index].dy,
              child: SizedBox(
                width: width,
                height: height,
                child: Image.asset(
                  page.assetPaths[index],
                  fit: BoxFit.contain,
                ),
              ),
            );
          }),
        ),
      ),
      20.h,
      if (onboardingController.currentPage.value == 0)
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              const Text(
                'Powered by',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Image.asset(
                'assets/images/onboard/gemini_logo.png',
                height: 50,
              ),
            ],
          ),
        ),
      20.h,
      if (onboardingController.currentPage.value == 0)
        Align(
          alignment: Alignment.bottomCenter,
          child: TextButton(
            onPressed: () {
              Get.to(const SignInView());
            },
            child: RichText(
              text: const TextSpan(
                text: signInPrompt,
                style: TextStyle(color: primaryColor),
                children: <TextSpan>[
                  TextSpan(
                    text: signInText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    ];
  }

  Widget bgBlur() {
    return Positioned.fill(
      child: Container(
        color: Colors.white.withOpacity(0.7),
      ),
    );
  }

  Widget bgImage() {
    return Positioned.fill(
      child: Image.asset(
        "assets/images/onboard/onboard_bg.png",
        fit: BoxFit.cover,
      ),
    );
  }

Widget learningDepartmentInput() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "This will help us light up the path for your learning journey! 💡",
        style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 218, 120, 55),
            fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      Center(
        child: Obx(() {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: DropdownButton<String>(
              value: onboardingController.learningTopics.contains(
                          onboardingController.selectedLearningTopic.value)
                  ? onboardingController.selectedLearningTopic.value
                  : null,
              items: onboardingController.learningTopics.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                onboardingController.selectedLearningTopic.value = newValue!;
              },
              underline: Container(
                height: 0,
              ),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              dropdownColor: Colors.white,
              isExpanded: true,
            ),
          );
        }),
      ),
    ],
  );
}

  Widget professionalBackgroundInput() {
    return TextField(
      controller: onboardingController.professionalBackgroundController,
      maxLines: 7,
      decoration: const InputDecoration(
        hintText:
            """Example : I'm a computer scientist and I've been working in the field of artificial intelligence for the past 15 years. I currently lead a research team at a tech company focused on developing advanced machine learning algorithms.""",
        hintMaxLines: 7,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            width: 2,
            color: primaryColor,
          ),
        ),
      ),
    );
  }

  Widget aimInput(OnboardingPageModel page) {
    final CardModel createModel = CardModel(
      imagePath: 'assets/images/aim/create.png',
      title: 'Create',
      subtitle: 'Build a Resume, Write a Cover Letter, etc.',
    );

    final CardModel growModel = CardModel(
      imagePath: 'assets/images/aim/grow.png',
      title: 'Grow',
      subtitle: 'Learn new skills, Improve yourself, etc.',
    );

    return Column(
      children: [
        lPadding.h,
        GestureDetector(
          onTap: () {
            onboardingController.setPurpose("Create");
          },
          child: purposeCard(
            createModel,
            onboardingController.goal.value == "Create"
                ? Colors.blueGrey.withOpacity(0.2)
                : null,
          ),
        ),
        12.h,
        GestureDetector(
          onTap: () {
            onboardingController.setPurpose("Grow");
          },
          child: purposeCard(
            growModel,
            onboardingController.goal.value == "Grow"
                ? Colors.blueGrey.withOpacity(0.2)
                : null,
          ),
        ),
      ],
    );
  }

  CustomCard purposeCard(CardModel model, Color? color) {
    return CustomCard(
      height: smallCardSize,
      color: color,
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(model.imagePath),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.title,
                  style: subheadlineTextStyle.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  model.subtitle,
                  style: captionTextStyle.copyWith(
                      fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> nameInput(OnboardingPageModel page) {
    return [
      lPadding.h,
      TextField(
        controller: onboardingController.nameController,
        decoration: const InputDecoration(
          labelText: "Your full name",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              width: 2,
              color: primaryColor,
            ),
          ),
        ),
      ),
    ];
  }
}
