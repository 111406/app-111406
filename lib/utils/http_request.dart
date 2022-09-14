import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpRequest {
  Future<dynamic> post(String url, String reqeustData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dynamic result;
    await http
        .post(Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'token': token,
            },
            body: reqeustData)
        .then((response) {
      var responseJson = json.decode(utf8.decode(response.bodyBytes));
      result = responseJson;
      if (response.statusCode == 500) {
        throw Exception(result["message"]);
      }
      if (response.headers['token'] != null) {
        prefs.setString('token', response.headers['token']!);
      }
    });
    return result;
  }

  Future<dynamic> get(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dynamic result;
    await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token':token,
      },
    ).then((response) {
      var responseJson = json.decode(utf8.decode(response.bodyBytes));
      result = responseJson;
      if (response.statusCode == 500) {
        throw Exception(result["message"]);
      }
      if (response.headers['token'] != null) {
        prefs.setString('token', response.headers['token']!);
      }
    });
    return result;
  }
}

class HttpURL {
  // static const String host = "https://vaulted-epigram-349713.de.r.appspot.com";
  static const String host = "https://backend-111406.herokuapp.com";
}
