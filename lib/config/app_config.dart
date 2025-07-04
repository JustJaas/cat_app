import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  AppConfig._internal();

  static final AppConfig _instance = AppConfig._internal();
  static AppConfig get instance => _instance;

  late String baseUrl;
  late String apiKey;
  late Color colorPrimary;
  late Color colorSecondary;
  late Color colorTertiary;
  late Color colorQuaternary;
  late Color colorLetter;
  late Color colorAppBarLetter;
  late Color colorError;

  Future<void> initialize() async {
    await dotenv.load(fileName: ".env");

    baseUrl = dotenv.env['BASE_URL']!;
    apiKey = dotenv.env['API_KEY']!;
    colorPrimary = Colors.orange;
    colorSecondary = Colors.orange[100]!;
    colorTertiary = Colors.grey[600]!;
    colorQuaternary = Colors.grey[300]!;
    colorLetter = Colors.black;
    colorAppBarLetter = Colors.white;
    colorError = Colors.red;
  }

  String get getBaseUrl => baseUrl;
  String get getApiKey => apiKey;
  Color get getColor => colorPrimary;
  Color get getColorSecondary => colorSecondary;
  Color get getColorTertiary => colorTertiary;
  Color get getColorQuaternary => colorQuaternary;
  Color get getColorLetter => colorLetter;
  Color get getColorAppBarLetter => colorAppBarLetter;
  Color get getColorError => colorError;
}
