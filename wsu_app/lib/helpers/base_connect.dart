import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:wsu_app/config/env.dart';
import 'package:wsu_app/helpers/helpers.dart';

import 'logout.dart';

class BaseConnect extends GetConnect {
  @override
  void onInit() {
    super.onInit();

    httpClient.defaultDecoder = BaseResponse.fromJson;

    httpClient.baseUrl = kBaseApiUrl;

    httpClient.addRequestModifier((request) async {
      try {
        String token = await FirebaseAuth.instance.currentUser.getIdToken();

        if (token != null && !token.isBlank) request.headers['authorization'] = 'Bearer $token';
      } catch (e) {
        print(e);
      }

      print('Request: URL ${request.method.toUpperCase()}: ${request.url}');
      print('Request: Headers ${request.headers}');

      return request;
    });

    httpClient.addResponseModifier((request, response) async {
      print('Request: URL ${request.method.toUpperCase()}: ${request.url}');
      print('Request: Headers ${request.headers}');
      print('Response: Status ${response.statusCode}');
      print('Response: Status ${response.statusText}');
      print('Response: Body ${response.body.toString()}');

      if (response.hasError) {
        if (response.status.isUnauthorized) await logout();

        String error = '${response.statusCode}: ${response.statusText}';

        try {
          error = '$error - ${(response.body as BaseResponse).error.message}';
        } catch (e) {
          print(e);
        }

        throw error;
      }
    });

    httpClient.addAuthenticator((request) async {
      try {
        String token = await FirebaseAuth.instance.currentUser.getIdToken(true);

        if (token != null && !token.isBlank) request.headers['authorization'] = 'Bearer $token';
      } catch (e) {
        print(e);
      }

      return request;
    });

    httpClient.maxAuthRetries = 3;

    httpClient.timeout = Duration(seconds: 30);
  }
}
