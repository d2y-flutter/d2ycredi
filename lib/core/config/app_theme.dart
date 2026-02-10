import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color.dart';
import 'app_constants.dart';

class AppTheme {
  AppTheme._();

  // ============================================================
  // LIGHT THEME
  // ============================================================

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.background,
      
      colorScheme: const ColorScheme.light(
        primary: AppColor.primary,
        onPrimary: AppColor.textOnPrimary,
        primaryContainer: AppColor.primarySurface,
        onPrimaryContainer: AppColor.primaryDark,
        
        secondary: AppColor.secondary,
        onSecondary: AppColor.textOnPrimary,
        secondaryContainer: AppColor.secondarySurface,
        onSecondaryContainer: AppColor.secondaryDark,
        
        tertiary: AppColor.accent,
        onTertiary: AppColor.white,
        tertiaryContainer: AppColor.accentSurface,
        onTertiaryContainer: AppColor.accentDark,
        
        error: AppColor.error,
        onError: AppColor.white,
        errorContainer: AppColor.errorSurface,
        onErrorContainer: AppColor.errorDark,
        
        surface: AppColor.surface,
        onSurface: AppColor.textPrimary,
        surfaceContainerHighest: AppColor.surfaceVariant,
        
        outline: AppColor.border,
        outlineVariant: AppColor.borderLight,
        
        shadow: AppColor.shadowMedium,
        scrim: AppColor.overlay,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.textPrimary,
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColor.shadowLight,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(
          color: AppColor.textPrimary,
          size: AppConstants.iconMD,
        ),
        actionsIconTheme: const IconThemeData(
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
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          side: const BorderSide(
            color: AppColor.border,
            width: AppConstants.borderWidthThin,
          ),
        ),
        color: AppColor.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColor.shadowLight,
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

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.textOnPrimary,
          disabledBackgroundColor: AppColor.grey300,
          disabledForegroundColor: AppColor.grey500,
          shadowColor: Colors.transparent,
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

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColor.textPrimary,
          iconSize: AppConstants.iconMD,
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.white,
        elevation: 4,
      ),

      // Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColor.white,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: AppColor.grey500,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColor.white,
        indicatorColor: AppColor.primarySurface,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.inter(
              fontSize: AppConstants.fontSM,
              fontWeight: FontWeight.w600,
              color: AppColor.primary,
            );
          }
          return GoogleFonts.inter(
            fontSize: AppConstants.fontSM,
            color: AppColor.textSecondary,
          );
        }),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        elevation: 8,
        backgroundColor: AppColor.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColor.shadowMedium,
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
          height: 1.5,
        ),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColor.white,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: AppColor.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppConstants.radiusXL),
          ),
        ),
        elevation: 8,
        shadowColor: AppColor.shadowMedium,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColor.grey100,
        selectedColor: AppColor.primarySurface,
        disabledColor: AppColor.grey200,
        deleteIconColor: AppColor.textSecondary,
        side: const BorderSide(color: AppColor.border),
        labelStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontSM,
          color: AppColor.textPrimary,
        ),
        secondaryLabelStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontSM,
          color: AppColor.primary,
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

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        tileColor: AppColor.surface,
        selectedTileColor: AppColor.primarySurface,
        iconColor: AppColor.textSecondary,
        textColor: AppColor.textPrimary,
        titleTextStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontMD,
          fontWeight: FontWeight.w600,
          color: AppColor.textPrimary,
        ),
        subtitleTextStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontSM,
          color: AppColor.textSecondary,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingLG,
          vertical: AppConstants.paddingSM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        ),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColor.primary,
        circularTrackColor: AppColor.grey200,
        linearTrackColor: AppColor.grey200,
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
        elevation: 4,
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColor.white;
          }
          if (states.contains(WidgetState.disabled)) {
            return AppColor.grey400;
          }
          return AppColor.grey400;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColor.primary;
          }
          if (states.contains(WidgetState.disabled)) {
            return AppColor.grey300;
          }
          return AppColor.grey300;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
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
        side: const BorderSide(color: AppColor.border, width: 2),
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

      // Slider Theme
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColor.primary,
        inactiveTrackColor: AppColor.grey300,
        thumbColor: AppColor.primary,
        overlayColor: AppColor.primarySurface,
      ),

      // Tooltip Theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColor.grey900,
          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
        ),
        textStyle: GoogleFonts.inter(
          color: AppColor.white,
          fontSize: AppConstants.fontSM,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMD,
          vertical: AppConstants.paddingSM,
        ),
      ),

      // Text Selection Theme
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColor.primary,
        selectionColor: AppColor.primarySurface,
        selectionHandleColor: AppColor.primary,
      ),

      // Text Theme
      textTheme: GoogleFonts.interTextTheme(),
    );
  }

  // ============================================================
  // DARK THEME
  // ============================================================

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.darkBackground,
      
      colorScheme: const ColorScheme.dark(
        primary: AppColor.primary,
        onPrimary: AppColor.darkTextPrimary,
        primaryContainer: AppColor.primaryDark,
        onPrimaryContainer: AppColor.primaryLight,
        
        secondary: AppColor.secondary,
        onSecondary: AppColor.darkTextPrimary,
        secondaryContainer: AppColor.secondaryDark,
        onSecondaryContainer: AppColor.secondaryLight,
        
        tertiary: AppColor.accent,
        onTertiary: AppColor.darkTextPrimary,
        tertiaryContainer: AppColor.accentDark,
        onTertiaryContainer: AppColor.accentLight,
        
        error: AppColor.error,
        onError: AppColor.darkTextPrimary,
        errorContainer: AppColor.errorDark,
        onErrorContainer: AppColor.errorLight,
        
        surface: AppColor.darkSurface,
        onSurface: AppColor.darkTextPrimary,
        surfaceContainerHighest: AppColor.darkSurfaceVariant,
        
        outline: AppColor.darkBorder,
        outlineVariant: AppColor.darkBorderLight,
        
        shadow: AppColor.black,
        scrim: AppColor.overlayDark,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.darkBackground,
        foregroundColor: AppColor.darkTextPrimary,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        iconTheme: const IconThemeData(
          color: AppColor.darkTextPrimary,
          size: AppConstants.iconMD,
        ),
        actionsIconTheme: const IconThemeData(
          color: AppColor.darkTextPrimary,
          size: AppConstants.iconMD,
        ),
        titleTextStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontXL,
          fontWeight: FontWeight.w600,
          color: AppColor.white,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          side: const BorderSide(
            color: AppColor.darkBorder,
            width: AppConstants.borderWidthThin,
          ),
        ),
        color: AppColor.darkSurface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        margin: const EdgeInsets.all(AppConstants.spaceMD),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.darkSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingLG,
          vertical: AppConstants.paddingMD,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(
            color: AppColor.darkBorder,
            width: AppConstants.borderWidthNormal,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(
            color: AppColor.darkBorder,
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
          color: AppColor.darkTextHint,
          fontSize: AppConstants.fontMD,
        ),
        labelStyle: GoogleFonts.inter(
          color: AppColor.darkTextSecondary,
          fontSize: AppConstants.fontMD,
        ),
        errorStyle: GoogleFonts.inter(
          color: AppColor.error,
          fontSize: AppConstants.fontSM,
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.darkTextPrimary,
          disabledBackgroundColor: AppColor.darkBorder,
          disabledForegroundColor: AppColor.darkTextDisabled,
          shadowColor: Colors.transparent,
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

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColor.primary,
          disabledForegroundColor: AppColor.darkTextDisabled,
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

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColor.primary,
          disabledForegroundColor: AppColor.darkTextDisabled,
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

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColor.darkTextPrimary,
          iconSize: AppConstants.iconMD,
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.darkTextPrimary,
        elevation: 4,
      ),

      // Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColor.darkSurface,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: AppColor.darkTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColor.darkSurface,
        indicatorColor: AppColor.primaryDark,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.inter(
              fontSize: AppConstants.fontSM,
              fontWeight: FontWeight.w600,
              color: AppColor.primary,
            );
          }
          return GoogleFonts.inter(
            fontSize: AppConstants.fontSM,
            color: AppColor.darkTextSecondary,
          );
        }),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        elevation: 8,
        backgroundColor: AppColor.darkSurface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        ),
        titleTextStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontXL,
          fontWeight: FontWeight.w600,
          color: AppColor.darkTextPrimary,
        ),
        contentTextStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontMD,
          color: AppColor.darkTextSecondary,
          height: 1.5,
        ),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColor.darkSurface,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: AppColor.darkSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppConstants.radiusXL),
          ),
        ),
        elevation: 8,
        shadowColor: Colors.black,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColor.darkSurfaceVariant,
        selectedColor: AppColor.primaryDark,
        disabledColor: AppColor.darkBorder,
        deleteIconColor: AppColor.darkTextSecondary,
        side: const BorderSide(color: AppColor.darkBorder),
        labelStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontSM,
          color: AppColor.darkTextPrimary,
        ),
        secondaryLabelStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontSM,
          color: AppColor.primary,
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
        color: AppColor.darkBorder,
        thickness: AppConstants.borderWidthThin,
        space: 1,
      ),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        tileColor: AppColor.darkSurface,
        selectedTileColor: AppColor.darkSurfaceVariant,
        iconColor: AppColor.darkTextSecondary,
        textColor: AppColor.darkTextPrimary,
        titleTextStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontMD,
          fontWeight: FontWeight.w600,
          color: AppColor.darkTextPrimary,
        ),
        subtitleTextStyle: GoogleFonts.inter(
          fontSize: AppConstants.fontSM,
          color: AppColor.darkTextSecondary,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingLG,
          vertical: AppConstants.paddingSM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        ),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColor.primary,
        circularTrackColor: AppColor.darkBorder,
        linearTrackColor: AppColor.darkBorder,
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColor.darkSurfaceVariant,
        contentTextStyle: GoogleFonts.inter(
          color: AppColor.darkTextPrimary,
          fontSize: AppConstants.fontMD,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColor.darkTextPrimary;
          }
          if (states.contains(WidgetState.disabled)) {
            return AppColor.darkTextDisabled;
          }
          return AppColor.darkTextSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColor.primary;
          }
          if (states.contains(WidgetState.disabled)) {
            return AppColor.darkBorder;
          }
          return AppColor.darkBorder;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColor.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColor.darkTextPrimary),
        side: const BorderSide(color: AppColor.darkBorder, width: 2),
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
          return AppColor.darkTextSecondary;
        }),
      ),

      // Slider Theme
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColor.primary,
        inactiveTrackColor: AppColor.darkBorder,
        thumbColor: AppColor.primary,
        overlayColor: AppColor.primaryDark,
      ),

      // Tooltip Theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColor.darkSurfaceVariant,
          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
        ),
        textStyle: GoogleFonts.inter(
          color: AppColor.darkTextPrimary,
          fontSize: AppConstants.fontSM,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMD,
          vertical: AppConstants.paddingSM,
        ),
      ),

      // Text Selection Theme
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColor.primary,
        selectionColor: AppColor.primaryDark,
        selectionHandleColor: AppColor.primary,
      ),

      // Text Theme
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: AppColor.darkTextPrimary,
        displayColor: AppColor.darkTextPrimary,
      ),
    );
  }
}