import 'package:flutter/material.dart';

/// Mehfil's design system (docs/DESIGN-SYSTEM.md): light, structured like the
/// big apps. White ground, black primary actions, one indigo accent used in
/// small spots, Hanken Grotesk for text, Instrument Serif for one display
/// title per screen, JetBrains Mono for counts, clocks and codes.
abstract final class M {
  static const bg = Color(0xFFFFFFFF);
  static const surface = Color(0xFFF4F4F6);
  static const line = Color(0xFFE6E6EA);
  static const ink = Color(0xFF0E0E12);
  static const ink2 = Color(0xFF5F5F6B);
  static const ink3 = Color(0xFF9A9AA4);
  static const accent = Color(0xFF2F3BD8);
  static const ok = Color(0xFF13804B);

  // The camera screen is black, like every camera app.
  static const camBg = Color(0xFF000000);
  static const camPanel = Color(0xFF1C1C1F);
  static const camMuted = Color(0xFFA1A1AA);
  static const camOk = Color(0xFF3DDC84);

  static const sans = 'Hanken Grotesk';
  static const serif = 'Instrument Serif';
  static const mono = 'JetBrains Mono';

  static const margin = 20.0;
  static const rCard = 16.0;
  static const rPhoto = 12.0;

  static const display = TextStyle(
    fontFamily: serif,
    fontSize: 40,
    height: 1.1,
    fontWeight: FontWeight.w400,
    color: ink,
  );
  static const largeTitle = TextStyle(
    fontFamily: sans,
    fontSize: 32,
    height: 1.19,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: ink,
  );
  static const title = TextStyle(
    fontFamily: sans,
    fontSize: 22,
    height: 1.27,
    fontWeight: FontWeight.w700,
    color: ink,
  );
  static const headline = TextStyle(
    fontFamily: sans,
    fontSize: 17,
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: ink,
  );
  static const body = TextStyle(
    fontFamily: sans,
    fontSize: 17,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: ink,
  );
  static const subhead = TextStyle(
    fontFamily: sans,
    fontSize: 15,
    height: 1.33,
    fontWeight: FontWeight.w400,
    color: ink2,
  );
  static const footnote = TextStyle(
    fontFamily: sans,
    fontSize: 13,
    height: 1.38,
    fontWeight: FontWeight.w400,
    color: ink2,
  );
  static const caps = TextStyle(
    fontFamily: sans,
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
    color: ink3,
  );

  static TextStyle number(
    double size, {
    Color color = ink,
    FontWeight w = FontWeight.w600,
  }) => TextStyle(
    fontFamily: mono,
    fontSize: size,
    height: 1.2,
    fontWeight: w,
    color: color,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  /// Only things that float get a shadow (tab bar, sheet, toast).
  static const floatShadow = [
    BoxShadow(color: Color(0x140E0E12), blurRadius: 24, offset: Offset(0, 8)),
  ];

  static ThemeData theme() {
    final base = ThemeData(
      brightness: Brightness.light,
      fontFamily: sans,
      scaffoldBackgroundColor: bg,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      colorScheme: const ColorScheme.light(
        primary: ink,
        onPrimary: bg,
        secondary: accent,
        surface: bg,
        onSurface: ink,
        error: ink,
      ),
    );
    final field = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    );
    return base.copyWith(
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: ink,
        selectionColor: Color(0x332F3BD8),
        selectionHandleColor: accent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: body.copyWith(color: ink3),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: field,
        enabledBorder: field,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: ink, width: 1.2),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ink,
        contentTextStyle: footnote.copyWith(color: bg),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      datePickerTheme: const DatePickerThemeData(backgroundColor: bg),
      timePickerTheme: const TimePickerThemeData(backgroundColor: bg),
      dialogTheme: const DialogThemeData(backgroundColor: bg),
    );
  }
}
