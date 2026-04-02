import 'package:flutter/material.dart';
import 'package:stock_flow/app/theme/app_color_theme.dart';

class InfoDialog extends StatelessWidget {
  final String text;
  final String clickText;
  final IconData icon;
  final Function onClickOK;

  const InfoDialog({
    super.key,
    required this.text,
    required this.icon,
    required this.onClickOK,
    this.clickText = "OK",
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) => false,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(
          text,
          style: const TextStyle(color: Colors.black87, fontSize: 16),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                appColorTheme(context).primary,
              ),
            ),
            onPressed: () => onClickOK(),
            child: Text(
              clickText,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
