import 'package:http/http.dart' as http;
import 'dart:convert';


class PreferencePutApi {
  static Future<http.Response> putPreference(String username, String prev, String next) async {
    // final url = Uri.parse('https://us-central1-gptjr-cc22f.cloudfunctions.net/get_translation?username=$username&sourcetext=$text');
    final url = Uri.parse('https://us-central1-gptjr-cc22f.cloudfunctions.net/add_pref?username=$username&p_from=$prev&p_to=$next');
    var a = await http.get(
      url,
      headers: {
        
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return a;
  }
}