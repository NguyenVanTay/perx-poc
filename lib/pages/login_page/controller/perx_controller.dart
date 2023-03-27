import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';


class PerxController extends GetxController {
  // API
  Dio dio = Dio();
  late String userToken;
  late String applicationToken;

  Future<void> getApplicationToken() async {
    String url = "${dotenv.get("PERX_HOST")}/v4/oauth/token";
    String method = "POST";
    Map<String, String> params = {
      "client_id": dotenv.get('PERX_CLIENT_ID'),
      "client_secret": dotenv.get('PERX_CLIENT_SECRET'),
      "grant_type": "client_credentials",
    };

    try {
      // call API
      var response = await dio.request(url,
          data: params, options: Options(method: method));

      // Assign application token
      applicationToken = response.data['access_token'];
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

   Future<void> isIdentifierExist(String identifier) async {
    String url = "${dotenv.get("PERX_HOST")}/v4/pos/user_accounts/search";
    String method = "GET";
    Map<String, String> params = {
      "identifier": identifier,
    };
    Map<String, String> headers = {"Authorization": "Bearer $applicationToken"};

    try {
      // call API
      var response = await dio.request(
        url,
        queryParameters: params,
        options: Options(method: method, headers: headers),
      );

      // code = 1 -> user not found
      response.data['code'] == 1 ? createUser(identifier) : getUserToken(identifier);
    } catch (e) {
      if (kDebugMode) print(e);
      createUser(identifier);
    }
  }

  Future<void> createUser(String identifier) async {
    String url = "${dotenv.get("PERX_HOST")}/v4/pos/user_accounts";
    String method = "POST";
    Map<String, String> params = {
      "identifier": identifier,
      "joined_at": DateTime.now().toIso8601String(),
    };
    Map<String, String> headers = {"Authorization": "Bearer $applicationToken"};

    try {
      // call API
      await dio.request(url,
          data: params, options: Options(method: method, headers: headers));
      getUserToken(identifier);
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<void> getUserToken(String identifier) async {
    String url = "${dotenv.get("PERX_HOST")}/v4/oauth/token";
    String method = "POST";
    Map<String, String> params = {
      "client_id": dotenv.get('PERX_CLIENT_ID'),
      "client_secret": dotenv.get('PERX_CLIENT_SECRET'),
      "grant_type": "client_credentials",
      "scope": "user_account(identifier:$identifier)",
    };

    try {
      // call API
      var response = await dio.request(url,
          data: params, options: Options(method: method));

      // Assign user token
      userToken = response.data['access_token'];

      // setState

    } catch (e) {
      if (kDebugMode) print(e);
    }
  }
 

 
}
