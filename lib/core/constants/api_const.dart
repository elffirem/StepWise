class APIConst {
  static const String baseUrl = 'http://10.0.2.2:8080';
  // static const String baseUrl = 'http://192.168.0.11:8080';

  static const String _api = '/api';

  /// Auth
  static const String _auth = '$_api/auth';
  static const String signIn = '$_auth/sign-in';
  static const String refreshToken = '$_auth/refresh-token';
  static const String signUp = '$_auth/sign-up';

  /// ChatBot
  static const String _chatBot = '$_api/chat-bot';
  static const String chatPrompt = '$_chatBot/chat';

  /// Apply Tools
  static const String _jobApply = '$_api/job-apply';
  static const String preparation = '$_jobApply/preparation';
  static const String tool = '$_jobApply/tool';

  static const String interview = '$preparation/interview';
  static const String languageSkill = '$preparation/language-skill';

  static const String resume = '$tool/resume';
  static const String coverLetter = '$tool/cover-letter';
  static const String emailResponse = '$tool/email-response';
  static const String writeCaption = '$tool/write-caption';

  /// Roadmap
  static const String roadmap = '$_api/roadmap';

  /// Mental Roadmap
  static const String mentalRoadmap = '$_api/mental-roadmap';
}
