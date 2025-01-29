// part of 'onboarding_view.dart';

// mixin OldOnboardingMixin on State<OldOnboardingView> {
//   final OnboardingController onboardingController = Get.put(OnboardingController());

//   void nextPage() {
//     onboardingController.nextPage();
//   }

//   void previousPage() {
//     onboardingController.previousPage();
//   }

//   bool isCurrentPage(int index) {
//     return onboardingController.currentPage.value == index;
//   }

//   bool isCurrentPageGreaterOrEqual(int index) {
//     return onboardingController.currentPage.value >= index;
//   }

//   String getCurrentPageTitle() {
//     return onboardingController.onboardingPages[onboardingController.currentPage.value].title;
//   }

//   String getCurrentPageDescription() {
//     return onboardingController.onboardingPages[onboardingController.currentPage.value].description;
//   }

//   void setPurpose(String purpose) {
//     onboardingController.setPurpose(purpose);
//   }

//   String getSelectedLearningTopic() {
//     return onboardingController.selectedLearningTopic.value;
//   }

//   void setSelectedLearningTopic(String value) {
//     onboardingController.selectedLearningTopic.value = value;
//   }
// }
