import 'package:flutter/material.dart';
import 'package:stock_flow/app/theme/app_color_theme.dart';
import 'package:stock_flow/app/theme/app_text_theme.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    super.key,
    required this.hintText,
    required this.title,
    required this.typeInput,
    this.controller,
  });

  final String hintText;
  final String title;
  final TextInputType typeInput;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: Text(
            title,
            style: appTextStyle(context).bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: appColorTheme(context).onSurface,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: typeInput,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
          style: appTextStyle(context).bodyMedium?.copyWith(
            fontWeight: FontWeight.normal,
            color: appColorTheme(context).onSurface,
          ),
        ),
      ],
    );
  }
}
