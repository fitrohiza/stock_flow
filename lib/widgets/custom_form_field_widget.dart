import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_flow/app/theme/app_color_theme.dart';
import 'package:stock_flow/app/theme/app_text_theme.dart';

class CustomeFormField extends StatelessWidget {
  const CustomeFormField({
    super.key,
    this.icon,
    this.maxLength,
    required this.hint,
    this.validate,
    required this.controller,
    this.isMultiline = false,
    this.isReadOnly = false,
    this.isTime = false,
    this.onTap,
    this.textInputAction,
    this.keyboardType,
    this.suffixText,
    this.inputFormatter,
  });

  final Icon? icon;
  final int? maxLength;
  final String hint;
  final FormFieldValidator<String>? validate;
  final TextEditingController controller;
  final bool isMultiline;
  final bool isReadOnly;
  final bool isTime;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? suffixText;
  final List<TextInputFormatter>? inputFormatter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validate,
      cursorColor: appColorTheme(context).primary,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: isReadOnly,
      maxLength: maxLength,
      inputFormatters: inputFormatter,
      onTap: onTap,
      textInputAction:
          textInputAction ??
          (isMultiline ? TextInputAction.newline : TextInputAction.next),
      style: appTextStyle(
        context,
      ).bodyMedium?.copyWith(fontWeight: FontWeight.w500),
      maxLines: isMultiline ? null : 1,
      minLines: isMultiline ? 5 : 1,
      keyboardType:
          keyboardType ??
          (isMultiline ? TextInputType.multiline : TextInputType.text),
      decoration: InputDecoration(
        filled: true,
        fillColor: appColorTheme(context).onPrimary,
        prefixIcon: icon,
        suffixIcon: (suffixText != null && suffixText!.isNotEmpty)
            ? null
            : (isReadOnly
                  ? Icon(
                      isTime
                          ? Icons.access_time_rounded
                          : Icons.calendar_today_outlined,
                      size: 20,
                      color: appColorTheme(context).primary,
                    )
                  : null),
        suffixText: suffixText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: appColorTheme(context).outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: appColorTheme(context).outlineVariant,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: appColorTheme(context).primary),
        ),
        hintText: hint,
        alignLabelWithHint: true,
      ),
    );
  }
}
