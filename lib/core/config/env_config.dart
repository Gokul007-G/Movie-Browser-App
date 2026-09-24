import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get tmdbApiKey => dotenv.env['TMDB_API_KEY'] ?? '';
}
