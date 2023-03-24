import 'package:dogs_park/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_friend_tab.dart';

class ChatsPage extends StatelessWidget {
  RxInt selectedTab = 0.obs;
  var tabWidgets = [ChatFriendTabScreen(), ChatFriendTabScreen()];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return DefaultTabController(
      length: tabWidgets.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text('Chats'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: TabBar(
                onTap: (value) {
                  selectedTab.value = value;
                },
                physics: BouncingScrollPhysics(),
                isScrollable: true,
                indicatorColor: theme.primaryColor,
                labelColor: theme.primaryColor,
                unselectedLabelColor: const Color(0xFF8A8A8F),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(
                    text: 'Groups',
                  ),
                  Tab(
                    text: 'Users',
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(children: tabWidgets),
      ),
    );
  }
}
