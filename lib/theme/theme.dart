import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkify/main.export.dart';

class KColors {
  KColors._();

  // static bool _isDark = false;
  // static void setDark(bool isDark) => _isDark = isDark;

  // Brand colors
  static const Color primary = Color(0xFF2D71F7);
  static const Color onPrimary = Color(0xFFEFF4FF);

  static const Color secondary = Color(0xFF2C2C2D);
  static const Color onSecondary = Color(0xFFE7E7E7);

  static const Color success = Color(0xFF40C4AA);
  static const Color warning = Color(0xFFFFBE4C);
  static const Color info = Color(0xFF33CFFF);
  static const Color error = Color(0xFFDF1C41);
  static const Color errorContainer = Color(0xFFFADBE1);

  // Neutral scale
  static const Color n1 = Color(0xFFFFFFFF);
  static const Color n2 = Color(0xFFF6F8FA);
  static const Color n3 = Color(0xFFECEFF3);
  static const Color n4 = Color(0xFFDFE1E7);
  static const Color n5 = Color(0xFFC1C7D0);
  static const Color n6 = Color(0xFFA4ACB9);
  static const Color n7 = Color(0xFF818898);
  static const Color n8 = Color(0xFF666D80);
  static const Color n9 = Color(0xFF36394A);
  static const Color n10 = Color(0xFF272835);
  static const Color n11 = Color(0xFF1A1B25);
  static const Color n12 = Color(0xFF0D0D12);

  // Background & surface
  static const Color backgroundLight = n2;
  static const Color backgroundDark = n11;
  // static Color get background => _isDark ? backgroundDark : backgroundLight;

  static const Color surfaceLight = n1;
  static const Color surfaceDark = n12;
  // static Color get surface => _isDark ? surfaceDark : surfaceLight;

  static const Color outlineLight = n4;
  static const Color outlineDark = n9;
  // static Color get outline => _isDark ? outlineDark : outlineLight;

  static const Color textLight = n12;
  static const Color textDark = n2;
  // static Color get text => _isDark ? textDark : textLight;
}

class AppTheme {
  const AppTheme._();

  // ---------------- LIGHT ----------------
  static const lightScheme = ColorScheme(
    brightness: Brightness.light,

    primary: KColors.primary,
    onPrimary: KColors.onPrimary,
    primaryContainer: Color(0xFFABC6FC),

    secondary: KColors.secondary,
    onSecondary: KColors.onSecondary,
    secondaryContainer: Color(0xFFABABAB),

    error: KColors.error,
    onError: KColors.n1,

    surface: KColors.backgroundLight,
    surfaceContainer: KColors.surfaceLight,
    onSurface: KColors.textLight,

    outline: KColors.outlineLight,
    outlineVariant: KColors.outlineDark,

    inverseSurface: KColors.surfaceDark,
    onInverseSurface: KColors.textDark,

    inversePrimary: KColors.secondary,

    scrim: Colors.black54,
  );

  // ---------------- DARK ----------------
  static const darkScheme = ColorScheme(
    brightness: Brightness.dark,

    primary: KColors.primary,
    onPrimary: KColors.onPrimary,

    // primaryContainer: Color(0xFFABC6FC),
    secondary: KColors.secondary,
    onSecondary: KColors.onSecondary,

    // secondaryContainer: Color(0xFFABABAB),
    error: KColors.error,
    onError: KColors.n1,

    surface: KColors.backgroundDark,
    surfaceContainer: KColors.surfaceDark,
    onSurface: KColors.textDark,

    outline: KColors.outlineDark,
    outlineVariant: KColors.outlineLight,

    inverseSurface: KColors.surfaceLight,
    onInverseSurface: KColors.textLight,

    inversePrimary: KColors.secondary,

    scrim: Colors.black54,
  );

  // ---------------- THEME DATA ----------------

  static ThemeData get lightTheme => FlexThemeData.light(
    colorScheme: lightScheme,
    appBarElevation: 0,
    appBarStyle: FlexAppBarStyle.scaffoldBackground,
    scaffoldBackground: KColors.backgroundLight,
    applyElevationOverlayColor: false,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 7,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    textTheme: textTheme(false),
  );
  static ThemeData get darkTheme => FlexThemeData.dark(
    colorScheme: darkScheme,
    appBarElevation: 0,
    appBarStyle: FlexAppBarStyle.scaffoldBackground,
    applyElevationOverlayColor: false,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 3,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    textTheme: textTheme(true),
  );

  static ThemeData theme(bool isDark) {
    final theme = isDark ? darkTheme : lightTheme;
    // final color = theme.colorScheme;

    return theme.copyWith(
      dividerColor: KColors.n4,
      dividerTheme: const DividerThemeData(color: KColors.n4, thickness: 1),
      inputDecorationTheme: InputDecorationThemeData(
        border: OutlineInputBorder(
          borderRadius: Corners.circleBorder,
          borderSide: BorderSide(color: isDark ? KColors.outlineDark : KColors.outlineLight),
        ),
        enabledBorder: enabledBorder(isDark),
        focusedBorder: focusedBorder(),
        errorBorder: const OutlineInputBorder(
          borderRadius: Corners.circleBorder,
          borderSide: BorderSide(color: KColors.error),
        ),
      ),
    );
  }

  static OutlineInputBorder focusedBorder() {
    return const OutlineInputBorder(
      borderRadius: Corners.circleBorder,
      borderSide: BorderSide(color: KColors.primary),
    );
  }

  static OutlineInputBorder enabledBorder(bool isDark) {
    return OutlineInputBorder(
      borderRadius: Corners.circleBorder,
      borderSide: BorderSide(color: isDark ? KColors.outlineDark : KColors.outlineLight),
    );
  }

  static BoxShadow shadow() => const BoxShadow(color: KColors.n3, blurRadius: 5, offset: Offset(-2, 5));

  static const font = GoogleFonts.manrope;

  static TextTheme textTheme(bool isDark) {
    final baseTheme = ThemeData(brightness: isDark ? Brightness.dark : Brightness.light);

    final tTheme = GoogleFonts.manropeTextTheme(baseTheme.textTheme);

    return tTheme.copyWith(
      //57
      displayLarge: tTheme.displayLarge,
      // 45
      displayMedium: tTheme.displayMedium,
      // 36
      displaySmall: tTheme.displaySmall,
      // 48
      headlineLarge: tTheme.headlineLarge,
      // 40
      headlineMedium: tTheme.headlineMedium,
      //32
      headlineSmall: tTheme.headlineSmall,
      //24
      titleLarge: tTheme.titleLarge,
      //20
      titleMedium: tTheme.titleMedium,
      //18
      titleSmall: tTheme.titleSmall,
      //18
      bodyLarge: tTheme.bodyLarge,
      //16
      bodyMedium: tTheme.bodyMedium,
      //14
      bodySmall: tTheme.bodySmall,
      //16
      labelLarge: tTheme.labelLarge,
      //14
      labelMedium: tTheme.labelMedium,
      //12
      labelSmall: tTheme.labelSmall,
    );
  }
}
