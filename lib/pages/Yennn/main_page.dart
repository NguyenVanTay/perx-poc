import 'package:dogs_park/controllers/main_page_controller.dart';
import 'package:dogs_park/pages/Yennn/community_amity.dart';
import 'package:dogs_park/pages/Yennn/market_page.dart';
import 'package:dogs_park/pages/perx/perx.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../main.dart';
import '../login_page/controller/amity_login_controller.dart';
import '../social/community/community_feed_screen.dart';
import '../social/social_home_page/home_feed_page.dart';
import 'admin_page.dart';
import 'other_page.dart';

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
    const OtherPage(),
    const MarketPage(),
    const AdminPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        //     floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.handyman,color: Colors.white,),
        //     backgroundColor: Colors.green,mini: true,
        //     ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,

        body: _widgetOptions.elementAt(mainPageController.selectedIndex.value),
        bottomNavigationBar: BottomNavigationBar(

          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items:  const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), label:"Perx"),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: "Community"),
            BottomNavigationBarItem(icon: Icon(Icons.content_paste_search_outlined), label: "Command"),
            BottomNavigationBarItem(icon: Icon(Icons.area_chart_rounded), label: "Market Place"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Administrator"),
          ],
          currentIndex: mainPageController.selectedIndex.value,
          //  selectedFontSize: 20,
          selectedItemColor: Colors.green,
          backgroundColor: Colors.white70,
          onTap: (index) => mainPageController.onItemTaped(index),
        ),
      ),
    );
  }
}
