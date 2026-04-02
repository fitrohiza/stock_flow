import 'package:flutter/material.dart';
import 'package:stock_flow/app/theme/app_color_theme.dart';
import 'package:stock_flow/app/theme/app_text_theme.dart';

class ChooseDialog extends StatelessWidget {
  final String text;
  final String clickText;
  final IconData icon;
  final Function onClickOK;
  final Function? onClickCancel;

  const ChooseDialog({
    super.key,
    required this.text,
    required this.icon,
    required this.onClickOK,
    this.onClickCancel,
    this.clickText = "OK",
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) => false,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          "Konfirmasi",
          style: appTextStyle(
            context,
          ).headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        content: Text(
          text,
          style: const TextStyle(color: Colors.black87, fontSize: 16),
        ),
        actions: <Widget>[
          onClickCancel != null
              ? TextButton(
                  onPressed: () => onClickCancel!(),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    side: WidgetStateProperty.all(
                      const BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : const SizedBox(),
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
