import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  AppConfig._internal();

  static final AppConfig _instance = AppConfig._internal();
  static AppConfig get instance => _instance;

  late String baseUrl;
  late String apiKey;

  Future<void> initialize() async {
    await dotenv.load(fileName: ".env");

    baseUrl = dotenv.env['BASE_URL']!;
    apiKey = dotenv.env['API_KEY']!;
  }

  String get getApiBaseUrl => baseUrl;
  String get getStripeApiKey => apiKey;
}
