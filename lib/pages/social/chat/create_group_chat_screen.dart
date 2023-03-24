import 'dart:developer';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:dogs_park/pages/login_page/controller/user_controller.dart';
import 'package:dogs_park/pages/social/controller/channel_controller.dart';
import 'package:dogs_park/pages/social/controller/image_picker_controller.dart';
import 'package:dogs_park/pages/widget/round_avatar_with_icon.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_screen.dart';

class CreateChatGroup extends StatefulWidget {
  const CreateChatGroup({
    Key? key,
    required this.userIds,
  }) : super(key: key);

  final List<String> userIds;

  @override
  _CreateChatGroupState createState() => _CreateChatGroupState();
}

class _CreateChatGroupState extends State<CreateChatGroup> {
  final UserController _userController = UserController.getInstance();
  ImagePickerController? _imagePickerController;
  String displayName = "";
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _imagePickerController = ImagePickerController();
  }

  Future<void> onCreateTap() async {
    _userController.selectedUserList.add(AmityCoreClient.getUserId());
    print("check user id list ${_userController.selectedUserList}");
    ChannelController.createGroupChannel(
        displayName, _userController.selectedUserList, (channel, error) {
      _userController.clearSelectedUser();
      if (channel != null) {
        Get.to(ChatSingleScreen(
          key: UniqueKey(),
          channel: channel.channels![0],
        ));
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //     builder: (context) => ChangeNotifierProvider(
        //           create: (context) => MessageVM(),
        //           child: ChatSingleScreen(
        //             key: UniqueKey(),
        //             channel: channel.channels![0],
        //           ),
        //         )));
      }
    }, avatarFileId: _imagePickerController!.amityImage?.fileId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Setup group", style: TextStyle(color: Colors.black)),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.chevron_left, color: Colors.black, size: 35),
          ),
          actions: [
            displayName != ""
                ? TextButton(
                    onPressed: () {
                      onCreateTap();
                    },
                    child: Text("Create"),
                  )
                : Container()
          ],
        ),
        body: SafeArea(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              width: double.infinity,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  FadedScaleAnimation(
                    child: GestureDetector(
                      onTap: () {
                        // Provider.of<ImagePickerVM>(context, listen: false)
                        //     .showBottomSheet(context);
                        _imagePickerController?.showBottomSheet(context);
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            'https://www.bsn.eu/wp-content/uploads/2016/12/user-icon-image-placeholder-300-grey.jpg'
                            // _imagePickerController!.amityImage!.fileUrl
                            ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 7,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.primaryColor,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    displayName = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Group name",
                  alignLabelWithHint: false,
                  border: InputBorder.none,
                  labelStyle: TextStyle(height: 1),
                ),
              ),
            ),
            Divider(
              color: AppColors.amity_lightGrey,
              thickness: 3,
            ),
          ],
        )));
  }
}
