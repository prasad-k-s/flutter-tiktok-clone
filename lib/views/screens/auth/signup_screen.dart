import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok_clone/constants.dart';
import 'package:flutter_tiktok_clone/views/widgets/text_input_filed.dart';
import 'package:get/get.dart';
import 'package:regexpattern/regexpattern.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  final _myFormKey = GlobalKey<FormState>();
  void register() {
    final isValid = _myFormKey.currentState!.validate();
    if (authController.isImagePicked == false) {
      Get.snackbar(
        'Profile Picture',
        'Please select a profile picture',
        icon: const Icon(
          Icons.warning,
          color: Colors.red,
          size: 35,
        ),
      );
    }

    if (isValid && authController.isImagePicked) {
      authController.register(
        _userNameController.text,
        _emailController.text,
        _passWordController.text,
        authController.profilePhoto,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: SafeArea(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'Tiktok Clone',
                    style: TextStyle(
                      color: buttonColor,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.grey,
                        backgroundImage: AssetImage('assets/images/default_profile_pic.png'),
                      ),
                      Positioned(
                        left: 80,
                        bottom: -10,
                        child: IconButton(
                          onPressed: () => authController.pickImage(),
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Form(
                    key: _myFormKey,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextInputField(
                            controller: _userNameController,
                            labelText: 'Username',
                            icon: Icons.lock,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your user name';
                              }
                              if (value.length < 4) {
                                return 'Username must contain atleast 4 characters';
                              }
                              if (value.isUsername() == false) {
                                return 'Please enter a valid user name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextInputField(
                            controller: _emailController,
                            labelText: 'Email',
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email address';
                              }
                              if (EmailValidator.validate(value) == false) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextInputField(
                            controller: _passWordController,
                            labelText: 'Password',
                            icon: Icons.lock,
                            isObscure: true,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 8) {
                                return 'Password must contain atleast 8 characters';
                              }
                              if (value.isPasswordHardWithspace() == false) {
                                return 'Please enter a valid password';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Text(
                            'Must contain at least: 1 uppercase letter,1 lowecase letter,1 number,1 special character and Minimum 8 characters.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: register,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: 50,
                            decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account? ",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "Login",
                                style: TextStyle(fontSize: 20, color: buttonColor!),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
