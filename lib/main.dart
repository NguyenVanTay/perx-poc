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
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var loggedUser = prefs.getString('loggedUser');
  // await setUpAmity();
  // runApp(
  //   GetMaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Dog Park',
  //     home: loggedUser == null
  //         ? const LoginPage()
  //         : UserApp(loggedUser: loggedUser),
  //     theme: defaultTheme,
  //     getPages: AppPages.pages,
  //   ),
  // );
  await dotenv.load(fileName: ".env");
  runApp(
    MaterialApp(
      home: const Perx(),
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
            TargetPlatform.values,
            value: (dynamic _) => const CupertinoPageTransitionsBuilder(),
          ),
        ),
      ),
    ),
  );
}

class UserApp extends StatefulWidget {
  const UserApp({required this.loggedUser, Key? key}) : super(key: key);
  final String loggedUser;
  // This widget is the root of your application.
  @override
  State<UserApp> createState() => _UserAppState();
}

class _UserAppState extends State<UserApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Networking.getInstance().getJSON(
          'PetsPark/hs/DogsPark/V1/Metadata?phonenumber=${widget.loggedUser}'),
      //sampleData(),
      builder: (context, snapchat) {
        if (snapchat.hasData) {
          dynamic value = snapchat.data;
          DataBucket.getInstance()
              .setMetaData(value['Metadata'], widget.loggedUser);
          var user = DataBucket.getInstance().getCustomerList();
          //check amity user
          var userAmity =
              UserRepository().getUser(user.phonenumber).then((value) {
            print(value);
            if (value.displayName != user.fullname) {
              // value.displayName = user.fullname;
              value.update().displayName(user.fullname).update().then((val) {
                print("Display name updated: " + val.displayName!);
              });
            }
          });

          //re render page switch
          // Controller.getInstance().handler();
          return const BottomBar();
        } else {
          return const LoadingAnimation();
        }
      },
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
