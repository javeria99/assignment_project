
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final Color borderColor;
  final double horizontalPadding;
  final double circularRadius;
  final String? hintText;
  final int?  maxLines;
  final Color? hintColor;
  final String? labelText;
  final Color textColor;
  final Color cursorColor;
  final bool readOnly;
  final bool obscureText;
  final Color? suffixIconColor;
  final Widget? suffixIcon;
  final Color? prefixIconColor;
  final Color? backgroundColor;
  final Widget? prefixIcon;
  Function(String)? onChanged;
  Function(String?)? onSaved;
  final TextInputType keyBoardType;
  final List<TextInputFormatter>? inputFormatterss;

  RoundedTextField({
    super.key,
    this.maxLines,
    required this.circularRadius,
    required this.backgroundColor,
    required this.controller,
    required this.borderColor,
    required this.horizontalPadding,
    this.hintText,
    this.hintColor,
    this.labelText,
    required this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIconColor,
    required this.textColor,
    required this.readOnly,
    required this.cursorColor,
    required this.keyBoardType,
    this.inputFormatterss,
    this.onChanged,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10,),
        decoration: BoxDecoration(
          color: backgroundColor,
            borderRadius: BorderRadius.circular(circularRadius),
            border: Border.all(color: borderColor)
            // border: Border(
            //   bottom: BorderSide(
            //     color: borderColor,
            //     style: BorderStyle.solid
            //   ),
            // ),
            ),
        child: Center(
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            style:  TextStyle(fontSize: 16,color: textColor),
            onChanged: onChanged,
            obscureText: obscureText,
            controller: controller,
            onSaved: onSaved,
            maxLines: maxLines,
            keyboardType: keyBoardType,
            inputFormatters: inputFormatterss,
            readOnly: readOnly,
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              suffixIcon: suffixIcon,
              suffixIconColor: suffixIconColor,
              prefixIcon: prefixIcon,
              prefixIconColor: prefixIconColor,
              border: InputBorder.none,
              labelStyle: const TextStyle(
                fontSize: 16,
              ),
              hintStyle:  TextStyle(fontSize: 16,color: hintColor),
            ),
            cursorColor: cursorColor, // Set cursor color
            // Apply the CNIC validation function
          ),
        ),
      ),
    );
  }
}
