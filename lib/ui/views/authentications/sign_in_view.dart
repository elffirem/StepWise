import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_wise/controller/auth/sign_in_controller.dart';
import 'package:step_wise/core/constants/constants.dart';
import 'package:step_wise/model/auth/sign_up_request_model.dart';
import 'package:step_wise/ui/components/custom_button.dart';
import 'package:step_wise/ui/views/authentications/sign_up_view.dart';

import '../../../model/roadmap/create_roadmap_request_model.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SignInController _signInController = Get.put(SignInController());

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      _signInController.setEmail(_emailController.text);
      _signInController.setPassword(_passwordController.text);
      _signInController
          .signIn(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: primaryColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: lPadding),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    welcomeText,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  const Spacer(flex: 2),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      prefixIcon:
                          Icon(Icons.email_outlined, color: primaryColor),
                      labelText: emailLabel,
                      labelStyle: TextStyle(color: primaryColor),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return pleaseEnterYourEmail;
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return pleaseEnterAValidEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline, color: primaryColor),
                      labelText: passwordLabel,
                      labelStyle: TextStyle(color: primaryColor),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return pleaseEnterYourPassword;
                      } else if (value.length < 6) {
                        return passwordMustBeAtLeast6Characters;
                      }
                      return null;
                    },
                  ),
                  const Spacer(flex: 2),
                  Obx(
                    () => CustomButton(
                      height: 50,
                      width: 200,
                      title: _signInController.isLoading.value
                          ? loading
                          : signInText,
                      onTap: _signInController.isLoading.value ? null : _signIn,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpView(
                            createRoadmapRequestModel: CreateRoadmapRequestModel(),
                            signUpRequestModel: SignUpRequestModel(),
                          ),
                        ),
                      );
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: signInPrompt,
                        style: TextStyle(color: primaryColor),
                        children: <TextSpan>[
                          TextSpan(
                            text: signUpText,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
