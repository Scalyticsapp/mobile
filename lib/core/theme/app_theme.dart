import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const bg = Color(0xFF0C0C0C);
  static const s1 = Color(0xFF151515);
  static const s2 = Color(0xFF1C1C1C);
  static const s3 = Color(0xFF232323);
  static const border = Color(0x12FFFFFF);
  static const border2 = Color(0x1FFFFFFF);

  static const accent = Color(0xFFC8F064);
  static const a2 = Color(0xFF8FDFB8);
  static const a3 = Color(0xFFF0A96B);
  static const a4 = Color(0xFF7EC8F0);

  static const textPrimary = Color(0xFFF0EDE6);
  static const muted = Color(0xFF7A7772);
  static const muted2 = Color(0xFF4A4845);

  static const red = Color(0xFFE8594C);
  static const yellow = Color(0xFFF0C96B);
  static const green = Color(0xFF6FD98A);
}

class AppTheme {
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.bg,

        colorScheme: const ColorScheme.dark(
          primary: AppColors.accent,
          surface: AppColors.s1,
          onSurface: AppColors.textPrimary,
        ),

        /// 🔥 TEXT
        textTheme: GoogleFonts.dmSansTextTheme(
          ThemeData.dark().textTheme,
        ).apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        ),

        /// 🔥 APPBAR
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textPrimary),
          titleTextStyle: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),

        /// 🔥 BUTTON
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.bg,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        /// 🔥 NAVBAR THEME (BIAR SUPPORT FLOATING)
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.s1.withOpacity(0.9),
          elevation: 0,
          selectedItemColor: AppColors.accent,
          unselectedItemColor: AppColors.muted,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
        ),
      );
}

/// 🔥 TEXT STYLE
class AppText {
  static TextStyle get heading => GoogleFonts.playfairDisplay(
        fontSize: 26,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle get headingMd => GoogleFonts.playfairDisplay(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  static TextStyle get headingSm => GoogleFonts.playfairDisplay(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  static TextStyle get body => GoogleFonts.dmSans(
        fontSize: 13,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get caption => GoogleFonts.dmSans(
      fontSize: 11,
      color: AppColors.muted,
      height: 1.5,
    );

  static TextStyle get label => GoogleFonts.dmSans(
        fontSize: 10,
        color: AppColors.muted,
        letterSpacing: 1.2,
      );

  static TextStyle get sectionTitle =>
      GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: 1.2,
      );
}