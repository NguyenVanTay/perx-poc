import 'package:dogs_park/controllers/main_page_controller.dart';
import 'package:dogs_park/pages/Yennn/community_amity.dart';
import 'package:dogs_park/pages/perx/perx.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../main.dart';
import '../login_page/controller/amity_login_controller.dart';
import '../social/community/community_feed_screen.dart';
import '../social/social_home_page/home_feed_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final mainPageController = Get.put(MainPageController());
  final amityController = Get.put(AmityLoginController());
  static final List<Widget> _widgetOptions = <Widget>[
    const UserApp(),
    const Perx(),
    const HomeFeedPage(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(

        body: _widgetOptions.elementAt(mainPageController.selectedIndex.value),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items:  const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), label:"Perx"),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: "Community"),
            BottomNavigationBarItem(icon: Icon(Icons.other_houses_outlined), label: "Other"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Catalog"),
          ],
          currentIndex: mainPageController.selectedIndex.value,
          //  selectedFontSize: 20,
          selectedItemColor: Colors.orangeAccent,
          onTap: (index) => mainPageController.onItemTaped(index),
        ),
      ),
    );
  }
}
