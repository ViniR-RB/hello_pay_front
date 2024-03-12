sealed class Configuration {
  static const String _apiUrl = String.fromEnvironment("API_URL");
  static String get apiUrl => _apiUrl;
}
