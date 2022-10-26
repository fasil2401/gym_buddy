import 'dart:convert';
import 'package:gym/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  static final client = http.Client();
  static Future fetchDataPost({String? api, var params}) async {
    var responses = await client.post(Uri.parse('${Api.apiUrl}$api'),
        body: json.encode(params),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    if (responses.statusCode == 200) {
      var jsonResponse = jsonDecode(responses.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future fetchDataGet({String? api}) async {
    var responses = await client.get(
      Uri.parse(
        '${Api.apiUrl}$api',
      ),
      // headers: {
      //   "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      //   "Access-Control-Allow-Credentials":
      //       'true', // Required for cookies, authorization headers with HTTPS
      //   "Access-Control-Allow-Headers":
      //       "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      //   "Access-Control-Allow-Methods": "POST, OPTIONS"
      // },
    );
    if (responses.statusCode == 200) {
      var jsonResponse = jsonDecode(responses.body);
      print(jsonResponse);
      return jsonResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future fetchPincodeGet({String? api}) async {
    var responses = await client.get(
      Uri.parse(api!),
    );
    if (responses.statusCode == 200) {
      var jsonResponse = jsonDecode(responses.body);
      print(jsonResponse);
      return jsonResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
