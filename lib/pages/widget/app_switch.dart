import 'package:dogs_park/pages/daycarePackages_page/daycare_package_home.dart';
import 'package:dogs_park/pages/petsList_page/pets_list_page.dart';
import 'package:dogs_park/pages/signupPet_page/signup_pet_page.dart';
import 'package:dogs_park/pages/social/community/community_tabbar.dart';
import 'package:dogs_park/pages/social/social_home_page/home_feed_page.dart';
import 'package:dogs_park/pages/social/generated/l10n.dart';
import 'package:dogs_park/pages/social/social_notification_page/notification_page.dart';

import 'package:dogs_park/pages/userInformation_page/user_information_page.dart';
import 'package:flutter/material.dart';
// import 'package:dogs_park/pages/social_pages_clone/app_navigation/home/home_page.dart';

// ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _bottomNavIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    DaycarePackageHome(), //home
    PetLists(),
    //SignUpPetPage(), //product list
    //NotificationPage(),
    CommunityTabbar(),
    //HomePage(), //social
    HomeFeedPage(),
    UserInformationPage(),
  ];

  void reRender() {
    setState(() async {
      //navigateTo(context, const PageSwitch._internal());
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_bottomNavIndex)),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12.0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded),
              label: 'Pets list',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Mall',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Social',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
          currentIndex: _bottomNavIndex,
          unselectedItemColor: const Color(0xFFDADADA),
          selectedItemColor: const Color(0xff04CEBC),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
