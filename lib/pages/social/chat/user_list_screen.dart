import 'package:amity_sdk/amity_sdk.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:dogs_park/pages/social/controller/channel_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

import '../../login_page/controller/user_controller.dart';
import 'chat_screen.dart';
import 'create_group_chat_screen.dart';

class UserList extends StatefulWidget {
  UserList(Key key);
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  UserController _userController = UserController.getInstance();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // community = widget.community;

    _userController.clearSelectedUser();
    _userController.getUsers();
  }

  int getLength() {
    var length = _userController.getUserList().length;
    print('user list: $length');
    return length;
  }

  int getSelectedLength() {
    var length = _userController.selectedUserList.length;
    print('user selected list: $length');
    return length;
  }

  void onNextTap() async {
    if (getSelectedLength() > 1) {
      Get.to(
        CreateChatGroup(
            key: UniqueKey(), userIds: _userController.selectedUserList),
      );
    } else {
      ChannelController.createConversationChannel(
          [AmityCoreClient.getUserId(), _userController.selectedUserList[0]],
          (channel, error) {
        _userController.clearSelectedUser();
        if (channel != null) {
          Get.to(ChatSingleScreen(
            key: UniqueKey(),
            channel: channel.channels![0],
          ));
        }
      });
    }
  }

  void searchUser(String keyword) async {
    String token = _userController.accessToken;

    _userController.searchUser(keyword, token);
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: OutlineSearchBar(
        hintText: "Search user...",
        borderColor: Colors.transparent,
        backgroundColor: Colors.grey[200],
        searchButtonPosition: SearchButtonPosition.leading,
        searchButtonIconColor: Colors.grey[500],
        clearButtonColor: Colors.grey[400]!,
        onClearButtonPressed: (value) {
          Future.delayed(Duration.zero, () {
            _userController.getUsers();
          });
        },
        onTypingFinished: (value) {
          print("enter typing finished $value");

          searchUser(value);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        AppBar().preferredSize.height;

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Users", style: TextStyle(color: Colors.black)),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.chevron_left, color: Colors.black, size: 35),
        ),
        actions: [
          getSelectedLength() > 0
              ? TextButton(
                  onPressed: () {
                    onNextTap();
                  },
                  child: Obx(
                    () => Text(_userController.selectUserListLength > 1
                        ? "Next"
                        : "Create"),
                  ),
                )
              : Container()
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: bHeight,

                // color: ApplicationColors.lightGrey,
                child: FadedSlideAnimation(
                  beginOffset: Offset(0, 0.3),
                  endOffset: Offset(0, 0),
                  slideCurve: Curves.linearToEaseOut,
                  child: Column(
                    children: [
                      searchBar(),
                      getLength() < 1
                          ? Expanded(
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: theme.primaryColor),
                              ),
                            )
                          : Expanded(
                              child: Obx(
                                () => _userController
                                            .selectUserListLength.value >=
                                        0
                                    ? ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        // shrinkWrap: true,
                                        itemCount: getLength(),
                                        itemBuilder: (context, index) {
                                          return UserWidget(
                                            theme: theme,
                                            index: index,
                                            user: _userController
                                                .getUserList()[index],
                                          );
                                        },
                                      )
                                    : const SizedBox(),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserWidget extends StatelessWidget {
  UserWidget(
      {Key? key, required this.user, required this.theme, required this.index})
      : super(key: key);

  final ThemeData theme;
  final AmityUser user;
  final int index;

  final UserController _userController = UserController.getInstance();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(0),
              onTap: () {
                _userController.setSelectedUserList(
                    _userController.getUserList()[index].userId!);
                print("click index $index ${_userController.selectedUserList}");
              },
              leading: FadeAnimation(
                child: (user.avatarUrl != null)
                    ? CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: (NetworkImage(user.avatarUrl!)))
                    : CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/user_placeholder.png")),
              ),
              title: Text(
                user.displayName ?? "Category",
                style: theme.textTheme.bodyText1!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: _userController.checkIfSelected(
                      _userController.getUserList()[index].userId!)
                  ? Icon(
                      Icons.check_rounded,
                      color: theme.primaryColor,
                    )
                  : null,
            ),
            Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
