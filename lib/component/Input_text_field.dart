import 'package:flutter/material.dart';

import '../constants/AppColors.dart';

class Input_text_field extends StatelessWidget {
  final TextEditingController? myController;
  final FocusNode? focusNode;
  final FormFieldSetter? onFieldSubmittedValue;
  final FormFieldValidator? onValidator;
  final Icon? icons;
  final Widget? sufixicon;
  final bool? obscureTexts;
  final TextInputType keyboardType;
  final String? hint;
  Input_text_field({
    required this.myController,
    required this.focusNode,
    required this.onFieldSubmittedValue,
    required this.onValidator,
    required this.hint,
    required this.keyboardType,
    Key? key,
    this.icons,
    this.sufixicon,
    this.obscureTexts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureTexts!,
      controller: myController,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmittedValue,
      validator: onValidator,
      keyboardType: keyboardType,
      cursorHeight: 20,
      cursorColor: AppColors.orange,
      decoration: InputDecoration(
        suffixIcon: sufixicon,
        prefixIcon: icons,
        hintText: hint!,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: AppColors.orange),
        ),
      ),
    );
  }
}

class Input_text_field1 extends StatelessWidget {
  final TextEditingController? myController;
  final FocusNode? focusNode;
  final FormFieldSetter? onFieldSubmittedValue;
  final FormFieldValidator? onValidator;
  final Icon? icons;
  final Widget? sufixicon;
  final String? Function(String?)? onChanged;
  final bool? obscureTexts;
  final TextInputType keyboardType;
  final String? hint, lable;
  Input_text_field1({
    required this.myController,
    required this.focusNode,
    required this.onFieldSubmittedValue,
    required this.onValidator,
    required this.hint,
    required this.keyboardType,
    this.onChanged,
    Key? key,
    this.icons,
    this.sufixicon,
    this.obscureTexts,
    this.lable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureTexts!,
      controller: myController,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmittedValue,
      validator: onValidator,
      keyboardType: keyboardType,
      cursorHeight: 20,
      onChanged: onChanged,
      cursorColor: AppColors.orange,
      decoration: InputDecoration(
        suffixIcon: sufixicon,
        prefixIcon: icons,
        hintText: hint!,
        label: Text(lable.toString()),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: AppColors.orange),
        ),
      ),
    );
  }
}
