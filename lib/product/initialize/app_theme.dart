import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AppTheme {
  AppTheme(this.context);

  final BuildContext context;

  ThemeData get theme => ThemeData.light().copyWith(
          outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.all(24),
          ),
          textStyle: MaterialStateProperty.all<TextStyle?>(
            context.general.textTheme.titleMedium,
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: context.border.normalBorderRadius,
            ),
          ),
        ),
      ));
}
