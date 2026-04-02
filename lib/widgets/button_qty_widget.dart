import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stock_flow/app/theme/app_color_theme.dart';
import 'package:stock_flow/app/theme/app_text_theme.dart';

class ButtonQtyWidget extends StatelessWidget {
  const ButtonQtyWidget({
    super.key,
    required this.funLessQty,
    required this.qty,
    required this.funAddQty,
    required this.controller,
  });

  final VoidCallback funLessQty;
  final int qty;
  final VoidCallback funAddQty;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: IconButton(
            onPressed: funLessQty,
            icon: Icon(MingCute.minimize_line, size: 16),
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all(Size(20, 20)),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: BorderSide(color: appColorTheme(context).primary),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        SizedBox(
          width: Get.width * 0.2,
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
            keyboardType: TextInputType.number,
            style: appTextStyle(
              context,
            ).bodyLarge?.copyWith(color: appColorTheme(context).onSurface),
            controller: controller,
          ),
        ),
        SizedBox(width: 20),

        SizedBox(
          width: 30,
          height: 30,
          child: IconButton(
            onPressed: funAddQty,
            icon: Icon(MingCute.add_line, size: 16),
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all(Size(20, 20)),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: BorderSide(color: appColorTheme(context).primary),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
