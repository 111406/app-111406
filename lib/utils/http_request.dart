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
      if (responseJson["code"] == "1") {
        throw Exception(responseJson["message"]);
      }
    });
    return result;
  }
}

class HttpURL {
  static const String host = "https://vaulted-epigram-349713.de.r.appspot.com";
}
