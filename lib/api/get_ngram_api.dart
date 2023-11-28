import 'package:http/http.dart' as http;
import 'dart:convert';


class NgramsGetApi {
  static Future<http.Response> getNgrams(String sourceToken, String sourceText) async {
    final url = Uri.parse('https://us-central1-gptjr-cc22f.cloudfunctions.net/get_ngrams?sourcetoken=$sourceToken&sourcetext=$sourceText');
    var a = await http.get(
      url,
      headers: {
        
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return a;
  }
}