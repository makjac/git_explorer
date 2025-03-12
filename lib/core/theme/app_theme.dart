import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    const primaryColor = Color(0xFF0969da);
    const textColor = Color(0xFF24292F);
    const borderColor = Color(0xFFD0D7DE);
    const backgroundColor = Color(0xFFFFFFFF);
    const surfaceColor = Color(0xFFF6F8FA);
    const greenColor = Color(0xFF2EA043);

    const defaultTextStyle = TextStyle(
      fontFamily: 'Segoe UI',
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: textColor,
    );

    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      useMaterial3: true,

      textTheme: TextTheme(
        displayLarge: defaultTextStyle.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
        displayMedium: defaultTextStyle.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
        displaySmall: defaultTextStyle.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: defaultTextStyle.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),

        titleLarge: defaultTextStyle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: defaultTextStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: defaultTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),

        bodyLarge: defaultTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: defaultTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: defaultTextStyle.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF57606A),
        ),

        labelLarge: defaultTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: defaultTextStyle.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: defaultTextStyle.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),

      colorScheme: ColorScheme.light(
        primary: primaryColor,
        primaryContainer: primaryColor.withValues(alpha: .1),
        onPrimaryContainer: primaryColor,
        secondary: greenColor,
        onSecondary: Colors.white,
        secondaryContainer: greenColor.withValues(alpha: .1),
        onSecondaryContainer: greenColor,
        surface: surfaceColor,
        onSurface: textColor,
        error: const Color(0xFFCF222E),
      ),

      scaffoldBackgroundColor: backgroundColor,
      cardColor: surfaceColor,
      dividerColor: borderColor,
      disabledColor: const Color(0xFFEAEBEC),

      appBarTheme: AppBarTheme(
        color: backgroundColor,
        iconTheme: const IconThemeData(color: textColor),
        titleTextStyle: defaultTextStyle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        elevation: 1,
        shadowColor: Colors.black.withValues(alpha: .05),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: greenColor,
          foregroundColor: Colors.white,
          textStyle: defaultTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            height: 1.05,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: const Size(0, 32),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          iconSize: 16,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textColor,
          textStyle: defaultTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            height: 1.05,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: const Size(0, 32),
          side: const BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          iconSize: 16,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: defaultTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            height: 1.05,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          minimumSize: const Size(0, 32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          iconSize: 16,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        hintStyle: defaultTextStyle.copyWith(color: const Color(0xFF8B949E)),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
      ),

      popupMenuTheme: PopupMenuThemeData(
        color: backgroundColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: borderColor),
        ),
        textStyle: const TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),

      cardTheme: CardTheme(
        color: surfaceColor,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: borderColor),
        ),
        elevation: 0,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: surfaceColor,
        disabledColor: const Color(0xFFEFF1F3),
        selectedColor: const Color(0xFFDDF4FF),
        secondarySelectedColor: const Color(0xFFDDF4FF),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        labelStyle: defaultTextStyle.copyWith(fontSize: 12),
        secondaryLabelStyle: defaultTextStyle.copyWith(
          fontSize: 12,
          color: primaryColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderColor),
        ),
      ),

      tabBarTheme: TabBarTheme(
        labelColor: textColor,
        unselectedLabelColor: const Color(0xFF57606A),
        labelStyle: defaultTextStyle.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: defaultTextStyle,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: const Color(0xFF57606A),
        selectedLabelStyle: defaultTextStyle.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: defaultTextStyle.copyWith(fontSize: 12),
        elevation: 8,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: greenColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),

      sliderTheme: SliderThemeData(
        activeTrackColor: primaryColor,
        inactiveTrackColor: primaryColor.withValues(alpha: .2),
        thumbColor: primaryColor,
        overlayColor: primaryColor.withValues(alpha: .2),
        valueIndicatorColor: primaryColor,
        valueIndicatorTextStyle: defaultTextStyle.copyWith(color: Colors.white),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return greenColor;
          }
          return Colors.white;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return greenColor.withValues(alpha: .5);
          }
          return Colors.grey.withValues(alpha: .5);
        }),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return greenColor;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        side: const BorderSide(color: borderColor),
      ),

      dialogTheme: DialogTheme(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        titleTextStyle: defaultTextStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: defaultTextStyle,
      ),

      dividerTheme: const DividerThemeData(
        color: borderColor,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static ThemeData dark() {
    const primaryColor = Color(0xFF58A6FF);
    const textColor = Color(0xFFC9D1D9);
    const borderColor = Color(0xFF30363D);
    const backgroundColor = Color(0xFF0D1117);
    const surfaceColor = Color(0xFF161B22);
    const greenColor = Color(0xFF3FB950);

    const defaultTextStyle = TextStyle(
      fontFamily: 'Segoe UI',
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: textColor,
    );

    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      useMaterial3: true,

      textTheme: TextTheme(
        displayLarge: defaultTextStyle.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
        displayMedium: defaultTextStyle.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
        displaySmall: defaultTextStyle.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: defaultTextStyle.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),

        titleLarge: defaultTextStyle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: defaultTextStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: defaultTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),

        bodyLarge: defaultTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: defaultTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: defaultTextStyle.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF8B949E),
        ),

        labelLarge: defaultTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: defaultTextStyle.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: defaultTextStyle.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),

      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        onPrimary: Colors.white,
        primaryContainer: primaryColor.withValues(alpha: .15),
        onPrimaryContainer: primaryColor,
        secondary: greenColor,
        onSecondary: Colors.white,
        secondaryContainer: greenColor.withValues(alpha: .15),
        onSecondaryContainer: greenColor,
        surface: surfaceColor,
        onSurface: textColor,
        error: const Color(0xFFF85149),
        onError: Colors.white,
      ),

      scaffoldBackgroundColor: backgroundColor,
      cardColor: surfaceColor,
      dividerColor: borderColor,
      disabledColor: const Color(0xFF2D333B),

      appBarTheme: AppBarTheme(
        color: surfaceColor,
        iconTheme: const IconThemeData(color: textColor),
        titleTextStyle: defaultTextStyle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        elevation: 1,
        shadowColor: Colors.black.withValues(alpha: .3),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: greenColor,
          foregroundColor: Colors.white,
          textStyle: defaultTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            height: 1.05,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: const Size(0, 32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textColor,
          textStyle: defaultTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            height: 1.05,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: const Size(0, 32),
          side: const BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: defaultTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            height: 1.05,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          minimumSize: const Size(0, 32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: backgroundColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        hintStyle: defaultTextStyle.copyWith(color: const Color(0xFF8B949E)),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
      ),

      cardTheme: CardTheme(
        color: surfaceColor,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: borderColor),
        ),
        elevation: 0,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: surfaceColor,
        disabledColor: const Color(0xFF2D333B),
        selectedColor: const Color(0xFF051D4D),
        secondarySelectedColor: const Color(0xFF051D4D),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        labelStyle: defaultTextStyle.copyWith(fontSize: 12),
        secondaryLabelStyle: defaultTextStyle.copyWith(
          fontSize: 12,
          color: primaryColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderColor),
        ),
      ),

      tabBarTheme: TabBarTheme(
        labelColor: textColor,
        unselectedLabelColor: const Color(0xFF8B949E),
        labelStyle: defaultTextStyle.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: defaultTextStyle,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: const Color(0xFF8B949E),
        selectedLabelStyle: defaultTextStyle.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: defaultTextStyle.copyWith(fontSize: 12),
        elevation: 8,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: greenColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),

      sliderTheme: SliderThemeData(
        activeTrackColor: primaryColor,
        inactiveTrackColor: primaryColor.withValues(alpha: .2),
        thumbColor: primaryColor,
        overlayColor: primaryColor.withValues(alpha: .2),
        valueIndicatorColor: primaryColor,
        valueIndicatorTextStyle: defaultTextStyle.copyWith(color: Colors.white),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return greenColor;
          }
          return Colors.white;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return greenColor.withValues(alpha: .5);
          }
          return const Color(0xFF8B949E).withValues(alpha: .5);
        }),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return greenColor;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        side: const BorderSide(color: borderColor),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return greenColor;
          }
          return borderColor;
        }),
      ),

      dialogTheme: DialogTheme(
        backgroundColor: surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        titleTextStyle: defaultTextStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: defaultTextStyle,
      ),

      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: const Color(0xFF2D333B),
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: defaultTextStyle.copyWith(color: textColor, fontSize: 12),
      ),

      dividerTheme: const DividerThemeData(
        color: borderColor,
        thickness: 1,
        space: 1,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primaryColor,
        linearTrackColor: primaryColor.withValues(alpha: .2),
        circularTrackColor: primaryColor.withValues(alpha: .2),
      ),
    );
  }
}
