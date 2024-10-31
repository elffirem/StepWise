import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_wise/controller/auth/sign_up_controller.dart';
import 'package:step_wise/core/constants/constants.dart';
import 'package:step_wise/model/auth/sign_up_request_model.dart';
import 'package:step_wise/ui/components/custom_button.dart';
import 'package:step_wise/ui/views/authentications/sign_in_view.dart';

import '../../../model/roadmap/create_roadmap_request_model.dart';

class SignUpView extends StatefulWidget {
  final SignUpRequestModel signUpRequestModel;
  final CreateRoadmapRequestModel createRoadmapRequestModel;

  const SignUpView({
    required this.createRoadmapRequestModel,
    required this.signUpRequestModel,
    super.key,
  });

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SignUpController _signUpController = Get.put(SignUpController());
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _signUpController.setSignUpRequestModel(widget.signUpRequestModel);
    _signUpController.setCreateRoadmapRequestModel(
        widget.createRoadmapRequestModel);
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
                    toStartSignUp,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const Spacer(flex: 2),
                  Center(
                    child: TextFormField(
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
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon:
                            Icon(Icons.lock_outline, color: primaryColor),
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
                  ),
                  const Spacer(flex: 2),
                  Center(
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            height: 50,
                            width: 200,
                            title: signUpButtonText,
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                _signUpController
                                    .setEmail(_emailController.text);
                                _signUpController
                                    .setPassword(_passwordController.text);
                                await _signUpController.signUp();
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                          ),
                  ),
                  const Spacer(),
                  Center(
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
