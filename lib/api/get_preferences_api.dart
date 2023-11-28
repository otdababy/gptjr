import 'package:http/http.dart' as http;
import 'dart:convert';


class PreferenceGetApi {
  static Future<http.Response> getPreference(String username) async {
    final url = Uri.parse('https://us-central1-gptjr-cc22f.cloudfunctions.net/get_preferences?username=$username');
    var a = await http.get(
      url,
      headers: {
        
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return a;
  }
}