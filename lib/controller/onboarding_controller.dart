import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_wise/model/auth/sign_up_request_model.dart';
import 'package:step_wise/model/onboarding/onboarding_model.dart';
import 'package:step_wise/ui/views/authentications/sign_up_view.dart';

import '../model/roadmap/create_roadmap_request_model.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  var onboardingPages = <OnboardingPageModel>[].obs;

  var nameController = TextEditingController();
  var professionalBackgroundController = TextEditingController();
  var goal = ''.obs;

  var learningTopics = <String>[].obs;
  var selectedLearningTopic = ''.obs;

  SignUpRequestModel signUpRequestModel = SignUpRequestModel();
  CreateRoadmapRequestModel createRoadmapRequestModel =
      CreateRoadmapRequestModel();

  @override
  void onInit() {
    super.onInit();
    fetchOnboardingData();
    fetchLearningTopics();
  }

  void fetchOnboardingData() {
    var fetchedData = [
      OnboardingPageModel(
        title: "Welcome",
        description: "to Step Wise",
        assetPaths: ["assets/images/onboard/bunny.png"],
        positions: [
          const Offset(0.3, 0.1),
        ],
      ),
      OnboardingPageModel(
        title: "Create",
        description: "with Step Wise",
        assetPaths: [
          "assets/images/onboard/road1.png",
          "assets/images/onboard/bunny.png",
        ],
        positions: [
          const Offset(0.01, -0.18),
          const Offset(0.04, 0.01),
        ],
      ),
      OnboardingPageModel(
        title: "Grow",
        description: "with Step Wise",
        assetPaths: [
          "assets/images/onboard/road2.png",
          "assets/images/onboard/bunny.png",
        ],
        positions: [
          const Offset(0.01, -0.18),
          const Offset(0.6, 0.25),
        ],
      ),
      OnboardingPageModel(
        title: """Hello! I’m PathFinder. I will create schudules and study plans for you.
Let's start by your name! """,
        description: "",
        assetPaths: [],
        positions: [],
      ),
      OnboardingPageModel(
        title: "What is your purpose for using PathFinder?",
        description: "",
        assetPaths: [],
        positions: [],
      ),
      OnboardingPageModel(
        title: "Could you please provide your professional background?",
        description: "",
        assetPaths: [],
        positions: [],
      ),
      OnboardingPageModel(
        title: "What do you want to learn?",
        description: "",
        assetPaths: [],
        positions: [],
      ),
    ];

    onboardingPages.assignAll(fetchedData);
  }

  void fetchLearningTopics() {
    var topics = [
      "Software Engineering",
      "Backend Development",
      "Frontend Development",
      "Full Stack Development",
      "DevOps",
      "Cloud Computing",
      "Cybersecurity",
      "Database Management",
      "Blockchain Development",
      "Game Development",
      "Embedded Systems",
      "IoT (Internet of Things)",
      "Networking",
      "System Architecture",
      "Software Testing & QA",
      "Artificial Intelligence",
      "Data Science",
      "Machine Learning",
      "Deep Learning",
      "Natural Language Processing (NLP)",
      "Computer Vision",
      "Augmented Reality (AR)",
      "Virtual Reality (VR)",
      "Web Development",
      "Mobile Development (Flutter)",
      "Mobile Development (React Native)",
      "Mobile Engineering (Swift)",
      "Mobile Engineering (Kotlin)",
      "Mobile Engineering (Android Java)",
      "UI/UX Design",
      "Agile Methodologies",
      "Software Project Management",
      "API Development",
      "Microservices Architecture",
      "Serverless Computing",
      "Big Data",
      "Quantum Computing",
      "Containerization (Docker)",
      "Continuous Integration/Continuous Deployment (CI/CD)",
      "Software Design Patterns",
    ];

    learningTopics.assignAll(topics);
    if (topics.isNotEmpty) {
      selectedLearningTopic.value = topics.first;
    }
  }

  void nextPage() {
    FocusScope.of(Get.context!).unfocus();
    if (currentPage.value == 3 && nameController.text.isEmpty) {
      Get.snackbar("Warning", "Please enter your name to proceed.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (currentPage.value == 4 && goal.value.isEmpty) {
      Get.snackbar("Warning", "Please select your purpose to proceed.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (currentPage.value == 5 &&
        professionalBackgroundController.text.isEmpty) {
      Get.snackbar("Warning", "Please provide your professional background.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (currentPage.value < onboardingPages.length - 1) {
      currentPage.value++;
      if (currentPage.value == 7) {
        signUpRequestModel = signUpRequestModel.copyWith(
          fullName: nameController.text,
          purpose: goal.value,
        );
        createRoadmapRequestModel = createRoadmapRequestModel.copyWith(
          professionalBackground: professionalBackgroundController.text,
          goal: selectedLearningTopic.value,
        );

        Get.to(
          () => SignUpView(
            signUpRequestModel: signUpRequestModel,
            createRoadmapRequestModel: createRoadmapRequestModel,
          ),
        );
      }
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }

  void setPurpose(String purpose) {
    goal.value = purpose;
  }
}
