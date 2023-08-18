import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool secure;
  final void Function(String?)? onClick;
  final TextInputType inputType;
  final TextEditingController controller;
  const CustomTextFormField({
    Key? key,
    required this.hint,
    required this.icon,
    this.secure = false,
    this.inputType = TextInputType.text,
    required this.onClick,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return 'value is empty';
      //   }
      //   return '';
      // },
      controller: controller,
      onSaved: onClick,
      keyboardType: inputType,
      obscureText: secure,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: KMainColor,
        ),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
