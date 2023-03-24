import 'dart:math';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:dogs_park/pages/login_page/controller/user_controller.dart';

import 'package:dogs_park/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';

import 'package:provider/provider.dart';

import '../components/custom_user_avatar.dart';
import '../controller/channel_controller.dart';

import 'chat_screen.dart';
import 'user_list_screen.dart';

class ChatItems {
  String image;
  String name;

  ChatItems(this.image, this.name);
}

class ChatFriendTabScreen extends StatefulWidget {
  @override
  _ChatFriendTabScreenState createState() => _ChatFriendTabScreenState();
}

class _ChatFriendTabScreenState extends State<ChatFriendTabScreen> {
  @override
  void initState() {
    super.initState();
  }

  int getLength() {
    return ChannelController.getChannelList().length;
  }

  String getDateTime(String dateTime) {
    var convertedTimestamp =
        DateTime.parse(dateTime); // Converting into [DateTime] object
    var result = GetTimeAgo.parse(
      convertedTimestamp,
    );

    if (result == "0 seconds ago") {
      return "just now";
    } else {
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        AppBar().preferredSize.height;

    final theme = Theme.of(context);

    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () async {
        await ChannelController.refreshChannels();
      },
      child: Scaffold(
        body: FadedSlideAnimation(
          // ignore: sort_child_properties_last
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: AppColors.amity_lightGrey,
                  margin: EdgeInsets.only(top: 5),
                  child: Obx(
                    () => ChannelController.channelsLength > 0
                        ? ListView.builder(
                            controller: ChannelController.scrollController,
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: getLength(),
                            itemBuilder: (context, index) {
                              var messageCount =
                                  ChannelController.getChannelList()[index]
                                      .unreadCount;

                              bool _rand = messageCount > 0 ? true : false;

                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    Get.to(ChatSingleScreen(
                                        key: UniqueKey(),
                                        channel: ChannelController
                                            .getChannelList()[index]));
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (context) => ChangeNotifierProvider(
                                    //           create: (context) => MessageVM(),
                                    //           child: ChatSingleScreen(
                                    //             key: UniqueKey(),
                                    //             channel: vm.getChannelList()[index],
                                    //           ),
                                    //         )));
                                  },
                                  leading: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 5, 0),
                                        child: FadedScaleAnimation(
                                          child: getAvatarImage(null,
                                              fileId: ChannelController
                                                      .getChannelList()[index]
                                                  .avatarFileId),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: _rand
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  color: theme.primaryColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                padding: EdgeInsets.fromLTRB(
                                                    4, 0, 4, 2),
                                                child: Center(
                                                  child: Text(
                                                    ChannelController
                                                                .getChannelList()[
                                                            index]
                                                        .unreadCount
                                                        .toString(),
                                                    style: theme
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            color:
                                                                AppColors.white,
                                                            fontSize: 8),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ),
                                    ],
                                  ),
                                  title: Text(
                                    ChannelController.getChannelList()[index]
                                            .displayName ??
                                        "Display name",
                                    style: TextStyle(
                                      color: _rand
                                          ? theme.primaryColor
                                          : AppColors.black,
                                      fontSize: 13.3,
                                    ),
                                  ),
                                  subtitle: Text(
                                    ChannelController.getChannelList()[index]
                                        .latestMessage,
                                    style: theme.textTheme.subtitle2!.copyWith(
                                      color: theme.hintColor,
                                      fontSize: 10.7,
                                    ),
                                  ),
                                  trailing: Text(
                                    (ChannelController.getChannelList()[index]
                                                .lastActivity ==
                                            null)
                                        ? ""
                                        : getDateTime(ChannelController
                                                .getChannelList()[index]
                                            .lastActivity!),
                                    style: theme.textTheme.bodyText1!.copyWith(
                                        color: AppColors.grey, fontSize: 9.3),
                                  ),
                                ),
                              );
                            },
                          )
                        : const SizedBox(),
                  ),
                ),
              ),
            ],
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'chat',
          child: const Icon(Icons.person_add),
          backgroundColor: theme.primaryColor,
          onPressed: () {
            Get.to(UserList(UniqueKey()));
          },
        ),
      ),
    );
  }
}
