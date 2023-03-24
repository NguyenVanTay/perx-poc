import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

/// The default theme configuration.
ThemeData defaultTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        titleTextStyle: AppTextStyle.titleAppBarStyle,
        backgroundColor: Colors.white),
    primaryColor: AppColors.primary,
    fontFamily: Dimens.fontFamily,
    textTheme: const TextTheme(
      titleLarge: AppTextStyle.titleLarge,
      titleMedium: AppTextStyle.titleMedium,
      titleSmall: AppTextStyle.titleSmall,
    ));
