import 'package:flutter/material.dart';
import 'package:stock_flow/app/theme/app_color_theme.dart';
import 'package:stock_flow/app/theme/app_text_theme.dart';

class EmptyPage extends StatelessWidget {
  final String message;
  final IconData icon;
  const EmptyPage({super.key, required this.message, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 64, color: Colors.grey.shade300),
        Text(
          message,
          style: appTextStyle(
            context,
          ).bodyMedium?.copyWith(color: appColorTheme(context).outline),
        ),
      ],
    );
  }
}
