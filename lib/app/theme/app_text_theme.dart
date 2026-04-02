import 'package:flutter/material.dart';

TextTheme appTextStyle(BuildContext context) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  return baseTextTheme.copyWith(
    bodySmall: baseTextTheme.bodySmall?.copyWith(fontSize: 10.0),
  );
}
