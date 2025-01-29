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
              //           bgImage(),
              //           bgBlur(),
              Positioned.fill(
                child: Container(
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: sPadding),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: context.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
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
                              GestureDetector(
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
                                  height: 60,
                                  width: 200,
                                  title: nextButtonText,
                                ),
                              ),
                              30.h,
                              Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      onboardingController
                                          .onboardingPages.length,
                                      (index) => Obx(() {
                                        return Column(
                                          children: [                                                                                     
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0,),
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
    final CardModel schoolModel = CardModel(
      imagePath: 'assets/images/aim/create.png',
      title: 'School',
    
    );

    final CardModel programmingModel = CardModel(
      imagePath: 'assets/images/aim/grow.png',
      title: 'Programming',
    );
    final CardModel examPrepModel = CardModel(
      imagePath: 'assets/images/aim/create.png',
      title: 'Exam Prep',
    
    );

    final CardModel otherModel = CardModel(
      imagePath: 'assets/images/aim/grow.png',
      title: 'Other',
    );

    return Column(
      children: [
        mPadding.h,
        GestureDetector(
          onTap: () {
            onboardingController.setPurpose("School");
          },
          child: purposeCard(
            schoolModel,
            onboardingController.goal.value == "School"
                ? Colors.white
                : null,
          ),
        ),
        12.h,
        GestureDetector(
          onTap: () {
            onboardingController.setPurpose("Programming");
          },
          child: purposeCard(
            programmingModel,
            onboardingController.goal.value == "Programming"
                ? Colors.white
                : null,
          ),
        ),
        12.h,
        GestureDetector(
          onTap: () {
            onboardingController.setPurpose("Exam Prep");
          },
          child: purposeCard(
            examPrepModel,
            onboardingController.goal.value == "Exam Prep"
                ? Colors.white
                : null,
          ),
        ),
        12.h,
        GestureDetector(
          onTap: () {
            onboardingController.setPurpose("Other");
          },
          child: purposeCard(
            otherModel,
            onboardingController.goal.value == "Other"
                ? Colors.white
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
      child: 
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[   
          Text(
                model.title,
                style: cardTextStyle
              ),
           
         ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(model.imagePath),
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
          fillColor: cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              width: 2,
              color:primaryColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              width: 2,
              color: primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
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
