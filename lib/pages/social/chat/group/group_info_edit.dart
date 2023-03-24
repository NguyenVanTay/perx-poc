import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:flutter/material.dart';

import 'group_chat_screen.dart';

class GroupInfoEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final myAppBar = AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.chevron_left),
      ),
      title: Text(
        'Group Info',
        style: theme.textTheme.headline6,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar,
      body: FadedSlideAnimation(
        child: Container(
          width: mediaQuery.size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.amity_lightGrey,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Icon(
                    Icons.camera_alt,
                    size: 40,
                    color: AppColors.grey,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 30),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Add group name',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Divider(
                color: AppColors.amity_lightGrey,
                thickness: 2,
              ),
              Container(
                alignment: Alignment.center,
                height: 100,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Add a brief description',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Expanded(
                child: Container(color: AppColors.amity_lightGrey),
              ),
              Container(
                color: AppColors.amity_lightGrey,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //     builder: (context) => GroupChatScreen()));
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.primaryColor,
                    ),
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Create group',
                      style: theme.textTheme.button,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
