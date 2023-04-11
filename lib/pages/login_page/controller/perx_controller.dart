import 'dart:convert';

import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:dio/dio.dart';
import 'package:dogs_park/controllers/admin_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class PerxController extends GetxController {
  // API
  RxBool isLoading = true.obs;
  Dio dio = Dio();
  String? userId;
  String? userToken;
  String? applicationToken;
  final adminController = Get.put(AdminController());

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
      print("Acess Token: $applicationToken");
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<void> isIdentifierExist(String identifier, var userData) async {
    String url = "${dotenv.get("PERX_HOST")}/v4/pos/user_accounts/search?identifier=$identifier";
    String method = "GET";
    // Map<String, String> params = {
    //   "identifier": identifier,
    // };
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${applicationToken!.toString()}'
    };

    try {
      // call API
      var response = await dio.request(url,
        options: Options(method: method, headers: headers),
      );


      // code = 1 -> user not found
      userId =identifier;
      response.data['code'] == 1
          ? createUser(identifier, userData)
          : createUser(identifier,userData);
    } catch (e) {


      if (kDebugMode) createUser(identifier, userData);
      return;
    }
  }

  Future<void> createUser(String identifier, var userData) async {
    String url = "${dotenv.get("PERX_HOST")}/v4/pos/user_accounts";
    String method = "POST";
    Map<String, dynamic> params = {
      "first_name": userData['FirstName'],
      "identifier": userData['Code'],
      "last_name": userData['LastName'],
      "personal_properties": {
        "gender": userData['Gender'],
        "address": userData['Address'],
        "email": userData['Email'],
        "phone": userData['Mobile']
      },
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

  // Future<void> hihi() async {
  //   await getApplicationToken();
  //   isIdentifierExist();
  // }

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

      isLoading.value = false;
      userId =identifier;
      print("User Token: $userToken");
      // setState

    } catch (e) {
      if (kDebugMode) print(e);
    }
  }


  Future<void> issueLoyalty() async {
    String url = "${dotenv.get("PERX_HOST")}/v4/pos/loyalty_transactions";

    String method = "POST";

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${applicationToken!.toString()}'
    };


    Map<String, dynamic> params = {
      "user_account": {
        "identifier": "$userId"
      },
      "properties": {},
      "points": adminController.pointPerx.value == 0 ? 50:adminController.pointPerx.value ,
      "loyalty_program_id": 1
    };


    try {
      // call API
      var response = await dio.request(url, data: params, options: Options(method: method,headers: headers));

      // Assign user token
      var data = response.data;
      if(response.data['data']['transacted_at']!=null){
        CleverTapPlugin.recordEvent("Issue Loyalty", params);
        print("issue Loyalty called success");
      }



      // isLoading.value = false;

      // print("User Token: $userToken");
      // setState

    } catch (e) {
      if (kDebugMode) print(e);
    }


  }

  Future<void> triggerPerx() async {
    String url = "${dotenv.get("PERX_HOST")}/v4/pos/triggers";

    String method = "POST";

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${applicationToken!.toString()}'
    };


    Map<String, dynamic> params = {

        "uuid": "53341f92-a38a-485f-95f1-6257a1e366d3",
        "identifier": "$userId"

    };


    try {
      // call API
      var response = await dio.request(url, data: params, options: Options(method: method,headers: headers));

      // Assign user token
      var data = response.data;
      if(response.statusCode==200){
        CleverTapPlugin.recordEvent("Trigger Perx Used", params);
        print("Trigger Perx Used");
      }



      // isLoading.value = false;

      // print("User Token: $userToken");
      // setState

    } catch (e) {
      if (kDebugMode) print(e);
    }


  }







}
