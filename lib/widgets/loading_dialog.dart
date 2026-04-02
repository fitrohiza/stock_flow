import 'package:flutter/material.dart';
import 'package:stock_flow/app/theme/app_color_theme.dart';

class LoadingDialog extends StatelessWidget {
  final String text;

  const LoadingDialog({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
        child: CircularProgressIndicator(color: appColorTheme(context).primary),
      ),
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black87, fontSize: 16),
      ),
    );
  }
}
