import 'package:flutter/material.dart';
import 'package:stock_flow/app/theme/app_color_theme.dart';

class InputDialog extends StatelessWidget {
  final String text;
  final String clickText;
  final IconData icon;
  final Function(String) onClickOK;
  final Function? onClickCancel;

  const InputDialog({
    super.key,
    required this.text,
    required this.icon,
    required this.onClickOK,
    this.onClickCancel,
    this.clickText = "OK",
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController reasonController = TextEditingController();

    return PopScope(
      onPopInvokedWithResult: (didPop, result) => false,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.black87, fontSize: 16),
            ),
            TextField(
              controller: reasonController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Masukkan alasan penolakan",
                border: const UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: appColorTheme(context).primary),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          onClickCancel != null
              ? TextButton(
                  onPressed: () => onClickCancel!(),
                  style: ButtonStyle(
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
                    "Batal",
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
            onPressed: () {
              String reason = reasonController.text;
              onClickOK(reason);
            },
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
