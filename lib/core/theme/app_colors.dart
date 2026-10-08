import 'package:flutter/material.dart';

class AppColors {
  // --- Dark Mode Palette (Translucent Dark Glass Theme) ---
  static const Color backgroundDark = Color(0xFF07111F);
  static const Color backgroundSecondaryDark = Color(0xFF0C1B2D);
  static const Color surfaceDark = Color(0xFF0E2238);
  static const Color surfaceGlassDark = Color(0x9914273C); // rgba(20,39,60,0.60)
  static const Color glassBorderDark = Color(0x24FFFFFF);   // rgba(255,255,255,0.14)

  static const Color textPrimaryDark = Color(0xFFEAF4FF);
  static const Color textSecondaryDark = Color(0xFF91A8C0);
  static const Color textMutedDark = Color(0xFF647B96);

  // --- Light Mode Palette (Frosted Glass & Morning Sky Theme) ---
  static const Color backgroundLight = Color(0xFFF4F8FC);
  static const Color backgroundSecondaryLight = Color(0xFFE4EDF7);
  static const Color surfaceLight = Color(0xE6FFFFFF);
  static const Color surfaceGlassLight = Color(0xE6FFFFFF);
  static const Color glassBorderLight = Color(0xB3FFFFFF);

  static const Color textPrimaryLight = Color(0xFF18324D);
  static const Color textSecondaryLight = Color(0xFF42627D);
  static const Color textMutedLight = Color(0xFF6689A8);

  // --- Shadows ---
  static const Color shadowCoolLight = Color(0x1F3F6F9F);
  static const Color shadowCoolDark = Color(0x7300142D); // rgba(0,20,45,0.45)

  // --- Atmospheric Gradients ---
  static const RadialGradient darkAtmosphericGradient = RadialGradient(
    center: Alignment(0.0, -0.6),
    radius: 1.4,
    colors: [
      Color(0xFF0C1B2D),
      Color(0xFF07111F),
      Color(0xFF040A14),
    ],
    stops: [0.0, 0.6, 1.0],
  );

  static const RadialGradient lightAtmosphericGradient = RadialGradient(
    center: Alignment(0.0, -0.75),
    radius: 1.35,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFF4F8FC),
      Color(0xFFE4EDF7),
    ],
    stops: [0.0, 0.55, 1.0],
  );

  static BoxDecoration bgDecoration(BuildContext context) {
    return isDark(context)
        ? const BoxDecoration(gradient: darkAtmosphericGradient)
        : const BoxDecoration(gradient: lightAtmosphericGradient);
  }

  // --- Legacy / Constant Aliases ---
  static const Color background = backgroundDark;
  static const Color backgroundSecondary = backgroundSecondaryDark;
  static const Color surfaceGlass = surfaceGlassDark;
  static const Color glassBorder = glassBorderDark;
  static const Color textPrimary = textPrimaryDark;
  static const Color textSecondary = textSecondaryDark;
  static const Color textMuted = textMutedDark;

  // --- Single Accent Blue (Dark Mode) ---
  static const Color darkAccentBlue = Color(0xFF5EA8FF);

  // --- Legacy Synthwave Palette Aliases (Mapped to Single Blue #5EA8FF in Dark Mode) ---
  static const Color neonCyan = Color(0xFF5EA8FF);
  static const Color neonPink = Color(0xFF5EA8FF);
  static const Color neonPurple = Color(0xFF5EA8FF);
  static const Color neonBlue = Color(0xFF5EA8FF);
  static const Color neonGold = Color(0xFF5EA8FF);
  static const Color neonGreen = Color(0xFF5EA8FF);

  // --- Light Mode Icon System (Unified Cool Blue Family) ---
  static const Color iconPrimaryLight = Color(0xFF3F6F9F);
  static const Color iconActiveLight = Color(0xFF315F91);
  static const Color iconSecondaryLight = Color(0xFF6689A8);
  static const Color iconMutedLight = Color(0xFF91A8BC);

  // --- Light Mode Accents (Unified Cool Blue Palette) ---
  static const Color lightPurple = Color(0xFF3F6F9F);
  static const Color lightBlue = Color(0xFF315F91);
  static const Color lightCyan = Color(0xFF3F6F9F);
  static const Color lightPink = Color(0xFF3F6F9F);
  static const Color lightGold = Color(0xFF3F6F9F);
  static const Color lightGreen = Color(0xFF3F6F9F);

  // --- Gradients ---
  static const LinearGradient darkGlassGradient = LinearGradient(
    colors: [Color(0x24FFFFFF), Color(0x05FFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient synthwaveGradient = LinearGradient(
    colors: [Color(0xFF5EA8FF), Color(0xFF315F91)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [Color(0x33FFFFFF), Color(0x05FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyanBlueGradient = LinearGradient(
    colors: [Color(0xFF5EA8FF), Color(0xFF315F91)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient pinkPurpleGradient = LinearGradient(
    colors: [Color(0xFF5EA8FF), Color(0xFF315F91)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // --- Status & Utility Colors ---
  static const Color success = Color(0xFF00F5D4);
  static const Color warning = Color(0xFFFF9E00);
  static const Color error = Color(0xFFFF3B30);

  // --- Theme-Aware Dynamic Color Resolvers ---
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color bg(BuildContext context) => isDark(context) ? backgroundDark : backgroundLight;
  static Color bgSecondary(BuildContext context) => isDark(context) ? backgroundSecondaryDark : backgroundSecondaryLight;
  static Color cardBg(BuildContext context) => isDark(context) ? surfaceDark : surfaceLight;
  static Color cardGlass(BuildContext context) => isDark(context) ? surfaceGlassDark : surfaceGlassLight;
  static Color cardBorder(BuildContext context) => isDark(context) ? glassBorderDark : glassBorderLight;

  static Color text1(BuildContext context) => isDark(context) ? textPrimaryDark : textPrimaryLight;
  static Color text2(BuildContext context) => isDark(context) ? textSecondaryDark : textSecondaryLight;
  static Color textM(BuildContext context) => isDark(context) ? textMutedDark : textMutedLight;

  static Color icon1(BuildContext context) => isDark(context) ? darkAccentBlue : iconPrimaryLight;
  static Color iconActive(BuildContext context) => isDark(context) ? darkAccentBlue : iconActiveLight;
  static Color icon2(BuildContext context) => isDark(context) ? textSecondaryDark : iconSecondaryLight;

  static Color resolveAccent(BuildContext context, Color darkColor) {
    return isDark(context) ? darkAccentBlue : iconPrimaryLight;
  }

  static Color accentCyan(BuildContext context) => isDark(context) ? darkAccentBlue : iconPrimaryLight;
  static Color accentPink(BuildContext context) => isDark(context) ? darkAccentBlue : iconPrimaryLight;
  static Color accentPurple(BuildContext context) => isDark(context) ? darkAccentBlue : iconActiveLight;
  static Color accentBlue(BuildContext context) => isDark(context) ? darkAccentBlue : iconActiveLight;
  static Color accentGold(BuildContext context) => isDark(context) ? darkAccentBlue : iconPrimaryLight;
  static Color accentGreen(BuildContext context) => isDark(context) ? darkAccentBlue : iconPrimaryLight;
}
