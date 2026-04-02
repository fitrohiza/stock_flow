import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stock_flow/app/theme/app_color_theme.dart';
import 'package:stock_flow/app/utils/date_formatter.dart';

class TransactionsCard extends StatelessWidget {
  final String name;
  final String product;
  final String qty;
  final String? dateString;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const TransactionsCard({
    super.key,
    required this.name,
    required this.product,
    required this.qty,
    this.onTap,
    this.dateString,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text("Product: $product"),
          Text("Qty: $qty"),
          Divider(),
          Text(DateFormatUtils.formatEventDate(dateString, useTime: false)),
        ],
      ),
      trailing: IconButton(
        onPressed: onDelete,
        icon: Icon(MingCute.delete_2_fill, color: appColorTheme(context).error),
      ),
      contentPadding: EdgeInsets.fromLTRB(16, 10, 0, 10),
    );
  }
}
