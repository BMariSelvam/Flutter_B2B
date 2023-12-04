// ignore_for_file: file_names

import 'package:b2b/Helper/colors.dart';
import 'package:b2b/Helper/fonts.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? labelText;
  final String? hintText;
  final int? hight;
  final int? maxLength;
  final bool? click;
  final int? maxLines;
  final bool showCursr = true;
  final Color? fillColor;
  final Function(String)? onChanged;

  final TextInputType? keyboardType;
  final bool obscureText = false;
  final bool readOnly;
  final bool filled = true;

  final InputBorder inputBorder;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    this.validator,
    this.suffixIcon,
    this.labelText,
    this.keyboardType,
    required this.controller,
    obscureText = false,
    required this.readOnly,
    showCursr = true,
    filled = false,
    required this.inputBorder,
    this.hintText,
    this.hight,
    this.maxLength,
    this.click,
    this.maxLines,
    this.fillColor,
    this.onChanged,
    this.inputFormatters,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
        left: 5,
        right: 5,
      ),
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        readOnly: widget.readOnly,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        controller: widget.controller,
        validator: widget.validator,
        style: TextStyle(
          fontSize: 13,
          color: MyColors.black,
          fontFamily: MyFont.myFont,
          fontWeight: FontWeight.w900,
        ),
        decoration: InputDecoration(
          filled: widget.filled,
          fillColor: widget.fillColor,
          hintStyle: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: MyColors.greyText),
          hintText: widget.hintText,
          border: widget.inputBorder,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: MyColors.grey,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                // color: Color.fromARGB(255, 232, 12, 12),
                ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide(
              color: (widget.click == false) ? MyColors.mainTheme : MyColors.white,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
          suffixIcon: widget.suffixIcon,
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: MyColors.mainTheme,
            fontSize: 13,
            fontFamily: MyFont.myFont,
            fontWeight: FontWeight.w900,
          ),
        ),
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
      ),
    );
  }
}
