import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  TextEditingController textEditingController;
  String label;
  bool obscureText;
  String? errorText;
  String? hintText;
  Widget prefixIcon;
  Widget? suffixIcon;
  int? errorMaxLines;
  bool? filled;
  TextAlign? textAlign;

  InputWidget({
    super.key,
    required this.textEditingController,
    required this.obscureText,
    required this.prefixIcon,
    required this.label,
    this.errorText,
    this.hintText,
    this.suffixIcon,
    this.errorMaxLines,
    this.filled,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      obscureText: obscureText,
      decoration: InputDecoration(
        errorText: errorText,
        label: Text(label),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorMaxLines: errorMaxLines,
        filled: true,
        fillColor: Colors.grey[300],
        contentPadding: EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
      ),
    );
  }
}
