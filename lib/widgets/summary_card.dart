import 'package:flutter/material.dart';
import 'package:stock_flow/app/theme/app_text_theme.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color colors;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colors),
          const Spacer(),
          Text(
            value,
            style: appTextStyle(context).headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colors,
            ),
          ),
          Text(
            title,
            style: appTextStyle(
              context,
            ).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
