import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:style_snap/src/core/constants.dart';

class AppTheme {
  static ThemeData get theme {
    ThemeData base = ThemeData.light();

    return base.copyWith(
      scaffoldBackgroundColor: kSilverGray,
      cardColor: kPlatinumWhite,
      textTheme: base.textTheme.copyWith(
        bodySmall: base.textTheme.bodySmall!.copyWith(
          color: kDarkGray,
        ),
      ),
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      colorScheme: ColorScheme.fromSwatch(
        accentColor: kSkyBlue,
        primarySwatch: Colors.grey,
      ),
    );
  }

  static ThemeData get darkTheme {
    ThemeData base = ThemeData.dark();

    return base.copyWith(
      scaffoldBackgroundColor: kDarkGray,
      cardColor: kDarkerGray,
      textTheme: base.textTheme.copyWith(
        bodySmall: base.textTheme.bodySmall!.copyWith(
          color: kSilverGray,
        ),
      ),
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      colorScheme: ColorScheme.fromSwatch(
        accentColor: kSkyBlue,
        primarySwatch: Colors.grey,
      ),
    );
  }
}
