import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color.dart';
import 'app_constants.dart';

class AppTextStyles {
  AppTextStyles._();

  // Headings
  static TextStyle get h1 => GoogleFonts.inter(
        fontSize: AppConstants.fontHeading,
        fontWeight: FontWeight.bold,
        color: AppColor.textPrimary,
        height: 1.2,
      );

  static TextStyle get h2 => GoogleFonts.inter(
        fontSize: AppConstants.fontTitle,
        fontWeight: FontWeight.bold,
        color: AppColor.textPrimary,
        height: 1.3,
      );

  static TextStyle get h3 => GoogleFonts.inter(
        fontSize: AppConstants.fontXXXL,
        fontWeight: FontWeight.w600,
        color: AppColor.textPrimary,
        height: 1.3,
      );

  static TextStyle get h4 => GoogleFonts.inter(
        fontSize: AppConstants.fontXXL,
        fontWeight: FontWeight.w600,
        color: AppColor.textPrimary,
        height: 1.4,
      );

  static TextStyle get h5 => GoogleFonts.inter(
        fontSize: AppConstants.fontXL,
        fontWeight: FontWeight.w600,
        color: AppColor.textPrimary,
        height: 1.4,
      );

  static TextStyle get h6 => GoogleFonts.inter(
        fontSize: AppConstants.fontLG,
        fontWeight: FontWeight.w600,
        color: AppColor.textPrimary,
        height: 1.5,
      );

  // Body Text
  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: AppConstants.fontLG,
        fontWeight: FontWeight.normal,
        color: AppColor.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: AppConstants.fontMD,
        fontWeight: FontWeight.normal,
        color: AppColor.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: AppConstants.fontSM,
        fontWeight: FontWeight.normal,
        color: AppColor.textPrimary,
        height: 1.5,
      );

  // Labels
  static TextStyle get labelLarge => GoogleFonts.inter(
        fontSize: AppConstants.fontMD,
        fontWeight: FontWeight.w500,
        color: AppColor.textPrimary,
        height: 1.4,
      );

  static TextStyle get labelMedium => GoogleFonts.inter(
        fontSize: AppConstants.fontSM,
        fontWeight: FontWeight.w500,
        color: AppColor.textSecondary,
        height: 1.4,
      );

  static TextStyle get labelSmall => GoogleFonts.inter(
        fontSize: AppConstants.fontXS,
        fontWeight: FontWeight.w500,
        color: AppColor.textSecondary,
        height: 1.4,
      );

  // Buttons
  static TextStyle get buttonLarge => GoogleFonts.inter(
        fontSize: AppConstants.fontLG,
        fontWeight: FontWeight.w600,
        color: AppColor.textOnPrimary,
        letterSpacing: 0.5,
      );

  static TextStyle get buttonMedium => GoogleFonts.inter(
        fontSize: AppConstants.fontMD,
        fontWeight: FontWeight.w600,
        color: AppColor.textOnPrimary,
        letterSpacing: 0.5,
      );

  static TextStyle get buttonSmall => GoogleFonts.inter(
        fontSize: AppConstants.fontSM,
        fontWeight: FontWeight.w600,
        color: AppColor.textOnPrimary,
        letterSpacing: 0.5,
      );

  // Caption & Overline
  static TextStyle get caption => GoogleFonts.inter(
        fontSize: AppConstants.fontSM,
        fontWeight: FontWeight.normal,
        color: AppColor.textSecondary,
        height: 1.4,
      );

  static TextStyle get overline => GoogleFonts.inter(
        fontSize: AppConstants.fontXS,
        fontWeight: FontWeight.w500,
        color: AppColor.textSecondary,
        letterSpacing: 1.5,
        height: 1.4,
      );

  // Special Text Styles
  static TextStyle get link => GoogleFonts.inter(
        fontSize: AppConstants.fontMD,
        fontWeight: FontWeight.w500,
        color: AppColor.primary,
        decoration: TextDecoration.underline,
      );

  static TextStyle get error => GoogleFonts.inter(
        fontSize: AppConstants.fontSM,
        fontWeight: FontWeight.normal,
        color: AppColor.error,
        height: 1.4,
      );

  static TextStyle get success => GoogleFonts.inter(
        fontSize: AppConstants.fontSM,
        fontWeight: FontWeight.normal,
        color: AppColor.success,
        height: 1.4,
      );

  static TextStyle get warning => GoogleFonts.inter(
        fontSize: AppConstants.fontSM,
        fontWeight: FontWeight.normal,
        color: AppColor.warning,
        height: 1.4,
      );

  static TextStyle get info => GoogleFonts.inter(
        fontSize: AppConstants.fontSM,
        fontWeight: FontWeight.normal,
        color: AppColor.info,
        height: 1.4,
      );

  // Monospace (for code or numbers)
  static TextStyle get mono => GoogleFonts.jetBrainsMono(
        fontSize: AppConstants.fontMD,
        fontWeight: FontWeight.normal,
        color: AppColor.textPrimary,
        height: 1.5,
      );
}