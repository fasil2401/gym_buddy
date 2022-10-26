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
    print('${Api.apiUrl}$api');
    var responses = await client.get(
      Uri.parse(
        '${Api.apiUrl}$api',
      ),
    );
    if (responses.statusCode == 200) {
      var jsonResponse = jsonDecode(responses.body);
      // print(jsonResponse);
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

  static Future fetchDataRawBody(
      {required String api, required String data}) async {
    final response = await client.post(
      Uri.parse('${Api.apiUrl}$api'),
      headers: {"Content-Type": "application/json"},
      body: data,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      return jsonDecode(response.body);
    }
  }

  static Future patchDataRawBody(
      {required String api, required String data}) async {
    final response = await client.patch(
      Uri.parse('${Api.apiUrl}$api'),
      headers: {"Content-Type": "application/json"},
      body: data,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      return jsonDecode(response.body);
    }
  }
}
