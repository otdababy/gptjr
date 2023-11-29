import 'package:http/http.dart' as http;
import 'dart:convert';


class TranslationGetApi {
  static Future<http.Response> getTranslation(String username, int t, int p) async {
    final url = Uri.parse('https://us-central1-gptjr-cc22f.cloudfunctions.net/get_translation?username=$username&text=$t&p=$p');
    // final url = Uri.parse('https://us-central1-gptjr-cc22f.cloudfunctions.net/get_translation?username=$username&sourcetext=$text');
    
    var a = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return a;
  }
}