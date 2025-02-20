part of 'auth_check_view.dart';

mixin AuthCheckViewMixin on State<AuthCheckView> {
  @override
  void initState() {
    super.initState();
    //(behzod) use injection
    _loadTokenAndNavigate(sl<NetworkService>());
  }

  Future<void> _loadTokenAndNavigate(NetworkService networkManager) async {
    try {
      final sharedPreferencesManager = SharedPreferencesManager();
      await sharedPreferencesManager.init();
      String? token = sharedPreferencesManager.getString('token');//TODO controller da olmalı
      //const String token = "mockedToken";

      if (token !=null && token.isNotEmpty) {
        networkManager.setToken(token);
      }
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => (token ==null || token.isEmpty)
                  ? const OnboardingView()
                  : const MainScaffold(),
            ),
          );
        },
      );
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }
}
