import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color.dart';
import 'app_constants.dart';

class AppTheme {
  AppTheme._();

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.background,
      colorScheme: const ColorScheme.light(
        primary: AppColor.primary,
        secondary: AppColor.secondary,
        error: AppColor.error,
        surface: AppColor.surface,
        onPrimary: AppColor.textOnPrimary,
        onSecondary: AppColor.textOnPrimary,
        onError: AppColor.white,
        onSurface: AppColor.textPrimary,
      ),
      
      // AppBar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.textPrimary,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: const IconThemeData(
          color: AppColor.textPrimary,
          size: AppConstants.iconMD,
        ),
        titleTextStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontXL,
          fontWeight: FontWeight.w600,
          color: AppColor.textPrimary,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: AppConstants.elevationSM,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        ),
        color: AppColor.surface,
        surfaceTintColor: Colors.transparent,
        margin: const EdgeInsets.all(AppConstants.spaceMD),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingLG,
          vertical: AppConstants.paddingMD,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(
            color: AppColor.border,
            width: AppConstants.borderWidthNormal,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(
            color: AppColor.border,
            width: AppConstants.borderWidthNormal,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(
            color: AppColor.primary,
            width: AppConstants.borderWidthThick,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(
            color: AppColor.error,
            width: AppConstants.borderWidthNormal,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(
            color: AppColor.error,
            width: AppConstants.borderWidthThick,
          ),
        ),
        hintStyle: GoogleFonts.inter(
          color: AppColor.textHint,
          fontSize: AppConstants.fontMD,
        ),
        labelStyle: GoogleFonts.inter(
          color: AppColor.textSecondary,
          fontSize: AppConstants.fontMD,
        ),
        errorStyle: GoogleFonts.inter(
          color: AppColor.error,
          fontSize: AppConstants.fontSM,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.textOnPrimary,
          disabledBackgroundColor: AppColor.grey300,
          disabledForegroundColor: AppColor.grey500,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingXL,
            vertical: AppConstants.paddingMD,
          ),
          minimumSize: const Size(0, AppConstants.buttonHeightMD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: AppConstants.fontMD,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColor.primary,
          disabledForegroundColor: AppColor.grey500,
          side: const BorderSide(
            color: AppColor.primary,
            width: AppConstants.borderWidthNormal,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingXL,
            vertical: AppConstants.paddingMD,
          ),
          minimumSize: const Size(0, AppConstants.buttonHeightMD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: AppConstants.fontMD,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColor.primary,
          disabledForegroundColor: AppColor.grey500,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLG,
            vertical: AppConstants.paddingSM,
          ),
          minimumSize: const Size(0, AppConstants.buttonHeightMD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: AppConstants.fontMD,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Icon Button Theme
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColor.textPrimary,
          iconSize: AppConstants.iconMD,
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColor.white,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: AppColor.grey500,
        type: BottomNavigationBarType.fixed,
        elevation: AppConstants.elevationMD,
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        elevation: AppConstants.elevationLG,
        backgroundColor: AppColor.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        ),
        titleTextStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontXL,
          fontWeight: FontWeight.w600,
          color: AppColor.textPrimary,
        ),
        contentTextStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontMD,
          color: AppColor.textSecondary,
        ),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColor.white,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppConstants.radiusXL),
          ),
        ),
        elevation: AppConstants.elevationLG,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColor.grey100,
        selectedColor: AppColor.primarySurface,
        deleteIconColor: AppColor.textSecondary,
        labelStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontSM,
          color: AppColor.textPrimary,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMD,
          vertical: AppConstants.paddingSM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColor.border,
        thickness: AppConstants.borderWidthThin,
        space: 1,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColor.primary,
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColor.grey900,
        contentTextStyle: GoogleFonts.inter(
          color: AppColor.white,
          fontSize: AppConstants.fontMD,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColor.white;
          }
          return AppColor.grey400;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColor.primary;
          }
          return AppColor.grey300;
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColor.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColor.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusXS),
        ),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColor.primary;
          }
          return AppColor.grey400;
        }),
      ),

      // Text Theme
      textTheme: GoogleFonts.interTextTheme(),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColor.primary,
        secondary: AppColor.secondary,
        error: AppColor.error,
        surface: AppColor.darkBackground,
        onPrimary: AppColor.textOnDark,
        onSecondary: AppColor.textOnDark,
        onError: AppColor.white,
        onSurface: AppColor.white,
      ),

      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.darkBackground,
        foregroundColor: AppColor.white,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(
          color: AppColor.white,
          size: AppConstants.iconMD,
        ),
        titleTextStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontXL,
          fontWeight: FontWeight.w600,
          color: AppColor.white,
        ),
      ),

      cardTheme: CardThemeData(
        elevation: AppConstants.elevationSM,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        ),
        color: AppColor.darkBackground,
        surfaceTintColor: Colors.transparent,
        margin: const EdgeInsets.all(AppConstants.spaceMD),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.darkBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingLG,
          vertical: AppConstants.paddingMD,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(
            color: AppColor.grey700,
            width: AppConstants.borderWidthNormal,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(
            color: AppColor.grey700,
            width: AppConstants.borderWidthNormal,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(
            color: AppColor.primary,
            width: AppConstants.borderWidthThick,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(
            color: AppColor.error,
            width: AppConstants.borderWidthNormal,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(
            color: AppColor.error,
            width: AppConstants.borderWidthThick,
          ),
        ),
        hintStyle: GoogleFonts.inter(
          color: AppColor.grey600,
          fontSize: AppConstants.fontMD,
        ),
        labelStyle: GoogleFonts.inter(
          color: AppColor.grey400,
          fontSize: AppConstants.fontMD,
        ),
        errorStyle: GoogleFonts.inter(
          color: AppColor.error,
          fontSize: AppConstants.fontSM,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.textOnDark,
          disabledBackgroundColor: AppColor.grey700,
          disabledForegroundColor: AppColor.grey500,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingXL,
            vertical: AppConstants.paddingMD,
          ),
          minimumSize: const Size(0, AppConstants.buttonHeightMD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: AppConstants.fontMD,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColor.darkBackground,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: AppColor.grey500,
        type: BottomNavigationBarType.fixed,
        elevation: AppConstants.elevationMD,
      ),

      dialogTheme: DialogThemeData(
        elevation: AppConstants.elevationLG,
        backgroundColor: AppColor.darkBackground,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        ),
        titleTextStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontXL,
          fontWeight: FontWeight.w600,
          color: AppColor.white,
        ),
        contentTextStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontMD,
          color: AppColor.grey300,
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColor.darkBackground,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppConstants.radiusXL),
          ),
        ),
        elevation: AppConstants.elevationLG,
      ),

      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    );
  }
}