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
      style: const TextStyle(color: kDarkPurple),
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

//Questions text fields
class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: kPurple,
          width: 1.0,
        ),
      ),
      child: TextFormField(
        style: const TextStyle(color: Colors.black87),
        cursorColor: kPurple,
        textCapitalization: TextCapitalization.sentences,
        maxLines: 5,
        // controller: _aboutMeContoller,
        validator: (value) {
          return null;
        },
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          labelStyle: TextStyle(color: Colors.black87),
          border: InputBorder.none,
          hintText: "Answer",
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.validator,
    this.preIcon = const SizedBox(),
    this.suffixIcon = const SizedBox(),
    this.isObsecure = false,
  }) : super(key: key);

  final String label;
  final Widget preIcon;
  final Widget suffixIcon;
  final bool isObsecure;
  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: preIcon,
      ),
      obscureText: isObsecure,
    );
  }
}
