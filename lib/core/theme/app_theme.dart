import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_wiki/core/theme/app_colors.dart';
import 'package:rick_and_morty_wiki/core/theme/app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        textTheme: GoogleFonts.montserratTextTheme(TextTheme(
          headlineLarge: AppTextStyles.title,
          bodyMedium: AppTextStyles.body,
          bodyLarge: AppTextStyles.bodyBold,
        )).apply(
          bodyColor: AppColors.content,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          titleTextStyle: AppTextStyles.appBar.copyWith(
            color: AppColors.content,
          ),
        ),
      );
}
