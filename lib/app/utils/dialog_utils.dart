import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_flow/widgets/choose_dialog.dart';
import 'package:stock_flow/widgets/info_dialog.dart';
import 'package:stock_flow/widgets/input_dialog.dart';
import 'package:stock_flow/widgets/loading_dialog.dart';

class DialogUtils {
  static bool isLoadingOpen = false;

  static void showInfoDialog(
    String message,
    String buttonText, {
    Function? onClick,
    bool closeOnOk = true,
    bool closePreDialog = false,
  }) {
    if (closePreDialog) closeDialog();
    Get.dialog(
      InfoDialog(
        text: message,
        onClickOK: () {
          if (onClick != null) {
            if (closeOnOk) {
              Get.back();
            }
            onClick();
          } else {
            Get.back();
          }
        },
        icon: Icons.check,
        clickText: buttonText,
      ),
      barrierDismissible: false,
    );
  }

  static void showInputDialog(
    String message,
    String buttonText, {
    required Function(String) onClick,
    bool closeOnOk = true,
    bool closePreDialog = false,
  }) {
    if (closePreDialog) closeDialog();

    Get.dialog(
      InputDialog(
        text: message,
        onClickOK: (inputText) {
          if (closeOnOk) {
            Get.back();
          }
          onClick(inputText);
        },
        icon: Icons.check,
        clickText: buttonText,
      ),
      barrierDismissible: false,
    );
  }

  static void showLoading(String message, {bool closePreDialog = false}) {
    isLoadingOpen = true;
    if (closePreDialog) closeDialog();
    Get.dialog(LoadingDialog(text: message), barrierDismissible: false);
  }

  static void showChoose(
    String message,
    String buttonText, {
    Function? onClick,
    bool closeOnOk = true,
    bool closePreDialog = false,
  }) {
    if (closePreDialog) closeDialog();
    Get.dialog(
      ChooseDialog(
        text: message,
        onClickOK: () {
          if (onClick != null) {
            if (closeOnOk) {
              Get.back();
            }
            onClick();
          } else {
            Get.back();
          }
        },
        icon: Icons.check,
        onClickCancel: () => Get.back(),
        clickText: buttonText,
      ),
      barrierDismissible: false,
    );
  }

  static void closeDialog() {
    isLoadingOpen = false;
    Get.back();
  }
}
