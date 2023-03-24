import 'package:dio/dio.dart';
import 'package:dogs_park/pages/perx/components/campaign/campaigns_carousel.dart';
import 'package:dogs_park/pages/perx/components/loyalty/loyalty_section.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'components/reward/reward_list.dart';

class Perx extends StatefulWidget {
  const Perx({super.key});

  @override
  State<Perx> createState() => _PerxState();
}

class _PerxState extends State<Perx> {
  final Color rewardsColor = Colors.orange;
  final Color voucherColor = Colors.pinkAccent.shade700;
  final Color campaignsColor = Colors.deepPurple;
  final Color badgesColor = Colors.green;

  // loading screen when have not get user token, otherwise render screen
  bool isLoading = true;

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
      Response response = await dio.request(url, data: params, options: Options(method: method));

      // Assign application token
      applicationToken = response.data['access_token'];
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<void> isIdentifierExist() async {
    String url = "${dotenv.get("PERX_HOST")}/v4/pos/user_accounts/search";
    String method = "GET";
    Map<String, String> params = {
      "identifier": "36107704-1627626940",
    };
    Map<String, String> headers = {"Authorization": "Bearer $applicationToken"};

    try {
      // call API
      Response response = await dio.request(
        url,
        queryParameters: params,
        options: Options(method: method, headers: headers),
      );

      // code = 1 -> user not found
      response.data['code'] == 1 ? createUser("36107704-1627626940") : getUserToken("36107704-1627626940");
    } catch (e) {
      if (kDebugMode) print(e);
      createUser("36107704-1627626940");
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
      await dio.request(url, data: params, options: Options(method: method, headers: headers));
      getUserToken("Khoicute");
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
      Response response = await dio.request(url, data: params, options: Options(method: method));

      // Assign user token
      userToken = response.data['access_token'];

      // setState
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<void> hihi() async {
    await getApplicationToken();
    isIdentifierExist();
  }

  @override
  initState() {
    hihi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // showSearch in appbar
      appBar: AppBar(
        // back button, scan QR code
        leading: IconButton(
          icon: Icon(Icons.adaptive.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_rounded),
            onPressed: () {
              if (kDebugMode) print("Khoicute");
            },
          ),
        ],
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Search promotions',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
            icon: Icon(Icons.search_rounded, color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          onTap: () {
            if (kDebugMode) print("Khoicute");
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  LoyaltySection(userToken: userToken),
                  CampaignsCarousel(userToken: userToken),
                  RewardList(userToken: userToken),
                ],
              ),
            ),
    );
  }
}
