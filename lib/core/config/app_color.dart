import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  // ============================================================
  // LIGHT THEME COLORS
  // ============================================================

  // Primary Colors (Blue)
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color primaryDark = Color(0xFF1E40AF);
  static const Color primarySurface = Color(0xFFEFF6FF);

  // Secondary Colors (Green)
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryLight = Color(0xFF6EE7B7);
  static const Color secondaryDark = Color(0xFF059669);
  static const Color secondarySurface = Color(0xFFECFDF5);

  // Accent Colors (Red/Orange)
  static const Color accent = Color(0xFFEF4444);
  static const Color accentLight = Color(0xFFF87171);
  static const Color accentDark = Color(0xFFDC2626);
  static const Color accentSurface = Color(0xFFFEF2F2);

  // Status Colors - Light
  static const Color statusLunas = Color(0xFF10B981); // Green
  static const Color statusBelum = Color(0xFFEF4444); // Red
  static const Color statusLunasLight = Color(0xFFD1FAE5);
  static const Color statusBelumLight = Color(0xFFFFE4E6);

  // Semantic Colors - Light
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF6EE7B7);
  static const Color successDark = Color(0xFF059669);
  static const Color successSurface = Color(0xFFECFDF5);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);
  static const Color errorSurface = Color(0xFFFEF2F2);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);
  static const Color warningSurface = Color(0xFFFEF3C7);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF93C5FD);
  static const Color infoDark = Color(0xFF2563EB);
  static const Color infoSurface = Color(0xFFEFF6FF);

  // Text Colors - Light
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textDisabled = Color(0xFF9CA3AF);
  static const Color textHint = Color(0xFFD1D5DB);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnDark = Color(0xFFFFFFFF);

  // Background Colors - Light
  static const Color background = Color(0xFFF9FAFB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF3F4F6);

  // Border Colors - Light
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderLight = Color(0xFFF3F4F6);
  static const Color borderDark = Color(0xFFD1D5DB);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // ============================================================
  // DARK THEME COLORS
  // ============================================================

  // Dark Background Colors
  static const Color darkBackground = Color(0xFF0F172A); // slate-900
  static const Color darkSurface = Color(0xFF1E293B); // slate-800
  static const Color darkSurfaceVariant = Color(0xFF334155); // slate-700
  static const Color darkCard = Color(0xFF1E293B);

  // Dark Text Colors
  static const Color darkTextPrimary = Color(0xFFF1F5F9); // slate-100
  static const Color darkTextSecondary = Color(0xFF94A3B8); // slate-400
  static const Color darkTextDisabled = Color(0xFF64748B); // slate-500
  static const Color darkTextHint = Color(0xFF475569); // slate-600

  // Dark Border Colors
  static const Color darkBorder = Color(0xFF334155); // slate-700
  static const Color darkBorderLight = Color(0xFF475569); // slate-600
  static const Color darkBorderDark = Color(0xFF1E293B); // slate-800

  // Dark Status Colors
  static const Color darkStatusLunas = Color(0xFF22C55E); // green-500
  static const Color darkStatusBelum = Color(0xFFEF4444); // red-500
  static const Color darkStatusLunasLight = Color(0xFF166534); // green-800
  static const Color darkStatusBelumLight = Color(0xFF991B1B); // red-800

  // Dark Semantic Surface Colors
  static const Color darkSuccessSurface = Color(0xFF14532D); // green-900
  static const Color darkErrorSurface = Color(0xFF7F1D1D); // red-900
  static const Color darkWarningSurface = Color(0xFF78350F); // amber-900
  static const Color darkInfoSurface = Color(0xFF1E3A8A); // blue-900

  // Overlay Colors
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);
  static const Color overlayDark = Color(0xB3000000);

  // Shimmer Colors
  static const Color shimmerBase = Color(0xFFE5E7EB);
  static const Color shimmerHighlight = Color(0xFFF3F4F6);
  static const Color darkShimmerBase = Color(0xFF334155);
  static const Color darkShimmerHighlight = Color(0xFF475569);

  // Shadow Colors
  static const Color shadowLight = Color(0x0A000000);
  static const Color shadowMedium = Color(0x1A000000);
  static const Color shadowDark = Color(0x33000000);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkPrimaryGradient = LinearGradient(
    colors: [primaryDark, primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ============================================================
  // CONTEXT-AWARE COLOR GETTERS
  // ============================================================

  static Color getBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackground
        : background;
  }

  static Color getSurface(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSurface
        : surface;
  }

  static Color getTextPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextPrimary
        : textPrimary;
  }

  static Color getTextSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextSecondary
        : textSecondary;
  }

  static Color getBorder(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorder
        : border;
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkCard
        : white;
  }
}