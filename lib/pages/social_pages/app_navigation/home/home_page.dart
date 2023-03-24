import 'package:flutter/material.dart';
import '../../app_navigation/home/home_following_screen.dart';

import '../../post/post/create_post_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: GlobalFeedTabScreen(),
        floatingActionButton: FloatingActionButton(
            backgroundColor: theme.primaryColor,
            child: Icon(Icons.add),
            onPressed: () async {
              await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CreatePostScreen2()));
            }),
      ),
    );
  }
}
