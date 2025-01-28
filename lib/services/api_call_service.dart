import 'dart:convert';

import 'package:http/http.dart';

statusCodeSuccess(num? statusCode) {
  // status code success checker
  if (statusCode == null) return false;
  return statusCode >= 200 && statusCode < 300;
}

// data, error , status
class ApiCallService {
  // Authorization
  static const String _auth = "Authorization";

  // header
  static final header = {
    "content-type": "application/json",
    "Accept": "application/json"
  };

  // can handle all api
  static const Duration timeout = Duration(seconds: 50);

  // timeout response.
  static Response timeoutResponse = Response(
    '{"data": "Request timeout check your connection","error":${true}, "status":"failed"}',
    500,
  );

  // connection problem response.
  static Response connectionProblem = Response(
    '{"data": "Please check your internet connection!", "error":${true}, "status":"failed"}',
    500,
  );

  static Future<String> _getToken() async => '';
  // await UserService.instance.getToken();

  // post call
  static Future<Response> postCall(String url, Map<String, dynamic> body,
      {required bool needToken}) async {
    needToken
        ? header[_auth] = 'Bearer ${await _getToken()}'
        : null; //'Bearer $token'
    try {
      Response response =
          await post(Uri.parse(url), headers: header, body: jsonEncode(body))
              .timeout(
        timeout,
        onTimeout: () => timeoutResponse,
      );
      return response;
    } catch (e) {
      return connectionProblem;
    }
  }

  // get call
  static Future<Response> getCall(String url, {required bool needToken}) async {
    needToken
        ? header[_auth] = 'Bearer ${await _getToken()}'
        : null; //'Bearer $token'
    try {
      Response response = await get(Uri.parse(url), headers: header).timeout(
        timeout,
        onTimeout: () => timeoutResponse,
      );
      return response;
    } catch (e) {
      //print(e);
      return connectionProblem;
    }
  }

  // patch call
  static Future<Response> patchCall(String url, Map<String, dynamic> body,
      {required bool needToken}) async {
    needToken
        ? header[_auth] = 'Bearer ${await _getToken()}'
        : null; //'Bearer $token'
    try {
      Response response =
          await patch(Uri.parse(url), headers: header, body: jsonEncode(body))
              .timeout(
        timeout,
        onTimeout: () => timeoutResponse,
      );
      return response;
    } catch (e) {
      return connectionProblem;
    }
  }
}
