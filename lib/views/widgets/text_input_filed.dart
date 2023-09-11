import 'package:flutter/material.dart';
import 'package:flutter_tiktok_clone/constants.dart';

class TextInputField extends StatelessWidget {
  const TextInputField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.icon,
      this.isObscure = false,
      required this.validator,
      required this.keyboardType,
      required this.textInputAction});
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool isObscure;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      style: const TextStyle(
        fontSize: 20,
      ),
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        floatingLabelStyle: const TextStyle(
          fontSize: 20,
          color: blueColor,
        ),
        labelStyle: const TextStyle(
          fontSize: 20,
        ),
        errorStyle: const TextStyle(
          fontSize: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: blueColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: buttonColor!,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: buttonColor!,
          ),
        ),
      ),
      obscureText: isObscure,
    );
  }
}
