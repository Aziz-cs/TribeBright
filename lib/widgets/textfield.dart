import 'package:flutter/material.dart';
import 'package:tribebright/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.label = '',
    required this.controller,
    required this.validator,
    this.preIcon = const SizedBox(),
    this.suffixIcon = const SizedBox(),
    this.isObsecure = false,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final Widget preIcon;
  final Widget suffixIcon;
  final bool isObsecure;
  final TextInputType inputType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kPurple,
      controller: controller,
      // textDirection: TextDirection.rtl,
      keyboardType: inputType,
      style: const TextStyle(color: Colors.black),
      validator: validator,
      decoration: InputDecoration(
        hintText: label,
        hintTextDirection: TextDirection.rtl,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: preIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 13),
      ),
      obscureText: isObsecure,
    );
  }
}
