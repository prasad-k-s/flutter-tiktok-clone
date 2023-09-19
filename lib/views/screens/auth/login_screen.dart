import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok_clone/constants.dart';
import 'package:flutter_tiktok_clone/views/screens/auth/signup_screen.dart';
import 'package:flutter_tiktok_clone/views/widgets/text_input_filed.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passWordController = TextEditingController();

  final _myFormKey = GlobalKey<FormState>();

  void login() async {
    final isValid = _myFormKey.currentState!.validate();
    if (isValid) {
      setState(() {
        isLoading = true;
      });
      await authController.loginUser(
        _emailController.text,
        _passWordController.text,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isLoading = false;
  bool isObscure = true;

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
                      'Login',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
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
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: login,
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
                                  "Login",
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
                                "Dont't have an account? ",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const SignUp();
                                    },
                                  ),
                                ),
                                child: Text(
                                  "Register",
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
