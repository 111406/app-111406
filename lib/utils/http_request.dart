import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpRequest {
  Future<dynamic> post(String url, String reqeustData) async {
    dynamic result;
    await http
        .post(Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: reqeustData)
        .then((response) {
      var responseJson = json.decode(utf8.decode(response.bodyBytes));
      result = responseJson;
      if (response.statusCode == 500) {
        throw Exception(result["message"]);
      }
    });
    return result;
  }

  Future<dynamic> get(String url) async {
    dynamic result;
    await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    ).then((response) {
      var responseJson = json.decode(utf8.decode(response.bodyBytes));
      result = responseJson;
      if (response.statusCode == 500) {
        throw Exception(result["message"]);
      }
    });
    return result;
  }
}

class HttpURL {
  // static const String host = "https://vaulted-epigram-349713.de.r.appspot.com";
  static const String host = "https://backend-111406.herokuapp.com";
}
