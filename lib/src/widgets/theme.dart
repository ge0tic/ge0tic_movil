import 'package:flutter/material.dart';
import 'package:ge0tic/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeChangeNotifier with ChangeNotifier {
  static ThemeData light() {
    TextButtonThemeData x = TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.blue[900],
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    return ThemeData(
      textButtonTheme: x,
      brightness: Brightness.light,
      primaryColor: Utils.primaryColor,
      splashColor: Utils.colorVerde(0.8),
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(
        secondary: Utils.blackColor,
      ),
      textTheme: GoogleFonts.nunitoTextTheme(ThemeData.light().textTheme),
    );
  }

  static ThemeData dark() {
    TextButtonThemeData x = TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    return ThemeData(
      textButtonTheme: x,
      brightness: Brightness.dark,
      primaryColor: Utils.primaryColor,
      bottomAppBarColor: Colors.white,
      splashColor: Utils.colorVerde(0.8),
      scaffoldBackgroundColor: Colors.black,
      backgroundColor: Colors.black,
      colorScheme: const ColorScheme.dark(
        secondary: Colors.white,
      ),
      textTheme: GoogleFonts.nunitoTextTheme(ThemeData.dark().textTheme),
    );
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  void setTheme(bool value) {
    _isDarkTheme = value;
    notifyListeners();
  }
}
