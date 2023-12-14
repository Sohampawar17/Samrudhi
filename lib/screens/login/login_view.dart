import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'login_model.dart';

class LoginViewScreen extends StatefulWidget {
  const LoginViewScreen({Key? key});

  @override
  State<LoginViewScreen> createState() => _LoginViewScreenState();
}

class _LoginViewScreenState extends State<LoginViewScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onViewModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF005BEA), Color(0xFF00C6FB)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      child: Logo(
                        Logos.android,
                        size: 70,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const AutoSizeText(
                      'Login to your account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      minFontSize: 25,
                    ),
                    const SizedBox(height: 25),
                    Form(
                      key: model.formGlobalKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: model.urlController,
                            style: const TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                              // labelText: "Username",
                              hintText: "Url",
                              hintStyle: const TextStyle(color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              prefixIcon: const Icon(FontAwesome.earth_asia,
                                  color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              filled: true,
                              fillColor: const Color.fromRGBO(255, 255, 255, 1),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 16.0),
                            ),
                            autofillHints: const [AutofillHints.url],
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: model.usernameController,
                            style: const TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                              // labelText: "Username",
                              hintText: "Username",
                              hintStyle: const TextStyle(color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              prefixIcon: const Icon(FontAwesome.person,
                                  color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              filled: true,
                              fillColor: const Color.fromRGBO(255, 255, 255, 1),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 16.0),
                            ),
                            autofillHints: const [AutofillHints.username],
                            onEditingComplete: () {
                              TextInput.finishAutofillContext();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            validator: (value) => model.validateUsername(value),
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            style: const TextStyle(color: Colors.black87),
                            controller: model.passwordController,
                            obscureText: model.obscurePassword,
                            decoration: InputDecoration(
                              // labelText: "Username",
                              hintText: "Password",
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    model.obscurePassword =
                                        !model.obscurePassword;
                                  });
                                },
                                child: Icon(
                                  model.obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                              hintStyle: const TextStyle(color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              prefixIcon: const Icon(FontAwesome.user_lock,
                                  color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              filled: true,
                              fillColor: const Color.fromRGBO(255, 255, 255, 1),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 16.0),
                            ),
                            autofillHints: const [AutofillHints.password],
                            onEditingComplete: () {
                              TextInput.finishAutofillContext();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            validator: (value) => model.validatePassword(value),
                          ),
                          const SizedBox(height: 36.0),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF007BFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (model.formGlobalKey.currentState!
                                    .validate()) {
                                  model.formGlobalKey.currentState!.save();
                                  model.loginwithUsernamePassword(context);
                                }
                              },
                              child: model.isloading
                                  ? LoadingAnimationWidget.hexagonDots(
                                      color: Colors.white,
                                      size: 18,
                                    )
                                  : const Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () async {
                              const url =
                                  'https://mobilecrm.erpdata.in/user-registration/new';
                              if (await canLaunchUrlString(url)) {
                                await launchUrlString(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                color: Color(0xFF007BFF),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
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
        ),
      ),
    );
  }
}
