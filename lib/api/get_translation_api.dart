import 'package:http/http.dart' as http;
import 'dart:convert';


class TranslationGetApi {
  static Future<http.Response> getTranslation(String username, int p) async {
    final url = Uri.parse('https://us-central1-gptjr-cc22f.cloudfunctions.net/get_trans?username=$username&text=$p&p=1');
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