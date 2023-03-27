import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:dogs_park/pages/login_page/login_page.dart';
import 'package:dogs_park/pages/perx/perx.dart';

import 'package:dogs_park/pages/widget/app_switch.dart';
import 'package:dogs_park/theme/theme.dart';
import 'package:dogs_park/utils/data_bucket.dart';
import 'package:dogs_park/utils/networking.dart';
import 'package:dogs_park/widgets/loading_animation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dogs_park/routes/app_pages.dart';

Future<dynamic> sampleData() async {
  return {
    'Metadata': [
      {
        "Customer": [
          {
            'FullName': "1",
            'PhoneNumber': "1",
            'Address': "0",
            'Gender': "Male",
            'DateOfBirth': DateTime.now().toString(),
            'Password': "1",
          }
        ],
        'OwnedDog': []
      },
    ]
  };
}

Future<void> main() async {
  var test;
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var loggedUser = prefs.getString('loggedUser');
  await setUpAmity();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dog Park',
      home: loggedUser == null ? const LoginPage() : UserApp(),
      theme: defaultTheme,
      getPages: AppPages.pages,
    ),
  );
  await dotenv.load(fileName: ".env");
  // runApp(
  //   MaterialApp(
  //     home: const Perx(),
  //     theme: ThemeData(
  //       pageTransitionsTheme: PageTransitionsTheme(
  //         builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
  //           TargetPlatform.values,
  //           value: (dynamic _) => const CupertinoPageTransitionsBuilder(),
  //         ),
  //       ),
  //     ),
  //   ),
  // );
}

class UserApp extends StatefulWidget {
  // String
  const UserApp({super.key});

  // This widget is the root of your application.
  @override
  State<UserApp> createState() => _UserAppState();
}

class _UserAppState extends State<UserApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Login Success'),
      ),
    );
  }
}

Future<void> setUpAmity() async {
  await runZonedGuarded(() async {
    // WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();
    // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await dotenv.load(fileName: ".env");
    AmityRegionalHttpEndpoint? amityEndpoint;
    if (dotenv.env["REGION"] != null) {
      var region = dotenv.env["REGION"]!.toLowerCase().trim();

      if (dotenv.env["REGION"]!.isNotEmpty) {
        print(region);
        print(dotenv.env['API_KEY']);
        switch (region) {
          case "":
            {
              print("REGION is not specify Please check .env file");
            }
            ;
            break;
          case "sg":
            {
              amityEndpoint = AmityRegionalHttpEndpoint.SG;
            }
            ;
            break;
          case "us":
            {
              amityEndpoint = AmityRegionalHttpEndpoint.US;
            }
            ;
            break;
          case "eu":
            {
              amityEndpoint = AmityRegionalHttpEndpoint.EU;
            }
            ;
        }
      } else {
        throw "REGION is not specify Please check .env file";
      }
    } else {
      throw "REGION is not specify Please check .env file";
    }

    await AmityCoreClient.setup(
        option: AmityCoreClientOption(
            apiKey: dotenv.env["API_KEY"]!, httpEndpoint: amityEndpoint!),
        sycInitialization: true);

    // await AmityCoreClient.newUserRepository()
    //     .getUser('joh2')
    //     .then((value) async {
    //   print('log with userID: ' + value.displayName!);
    // }).onError((error, stackTrace) async {
    //   print('errpr');
    // });
  }, ((error, stack) {
    // FirebaseCrashlytics.instance.recordError(error, stack);
  }));

  // print("User id:" + await AmityCoreClient.getUserId());
}
