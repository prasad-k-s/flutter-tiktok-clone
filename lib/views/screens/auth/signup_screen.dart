import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok_clone/constants.dart';
import 'package:flutter_tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:flutter_tiktok_clone/views/widgets/text_input_filed.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:regexpattern/regexpattern.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passWordController = TextEditingController();

  final TextEditingController _userNameController = TextEditingController();

  final _myFormKey = GlobalKey<FormState>();

  void register() async {
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
      setState(() {
        isLoading = true;
      });
      await authController.register(
        _userNameController.text,
        _emailController.text,
        _passWordController.text,
        authController.profilePhoto,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isObscure = true;
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Center(
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
                        CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.grey,
                          backgroundImage: authController.isImagePicked
                              ? Image.file(authController.profilePhoto!).image
                              : const AssetImage('assets/images/default_profile_pic.png'),
                        ),
                        Positioned(
                          left: 80,
                          bottom: -10,
                          child: IconButton(
                            onPressed: () async {
                              final result = await authController.pickImage();
                              if (result) {
                                setState(() {});
                              }
                            },
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
                              isPassword: false,
                              onTapIcon: () {},
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
                              isPassword: false,
                              onTapIcon: () {},
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
                              isObscure: isObscure,
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
                              isPassword: true,
                              onTapIcon: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
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
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const LoginScreen();
                                    },
                                  ),
                                ),
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
      ),
    );
  }
}
