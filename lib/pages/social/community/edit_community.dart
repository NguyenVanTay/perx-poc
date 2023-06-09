import 'package:amity_sdk/amity_sdk.dart';
import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:dogs_park/pages/social/community/community_controller.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditCommunityScreen extends StatefulWidget {
  AmityCommunity community;
  EditCommunityScreen(this.community);

  @override
  State<EditCommunityScreen> createState() => _EditCommunityScreenState();
}

class _EditCommunityScreenState extends State<EditCommunityScreen> {
  CommunityController controller = CommunityController();
  CommunityType communityType = CommunityType.public;
  TextEditingController _displayNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    // Provider.of<CommunityVM>(context, listen: false)
    //     .getUser(AmityCoreClient.getCurrentUser());

    _displayNameController.text = widget.community.displayName ?? "";
    _descriptionController.text = widget.community.description ?? "";
    _categoryController.text = widget.community.categories != null
        ? widget.community.categories![0]!.name!
        : "No category";
    communityType = widget.community.isPublic!
        ? CommunityType.public
        : CommunityType.private;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final myAppBar = AppBar(
      title: Text(
        "Edit Community",
        style: theme.textTheme.headline6,
      ),
      backgroundColor: AppColors.white,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.chevron_left, color: Colors.black, size: 30),
      ),
      elevation: 0,
      actions: [
        TextButton(
          onPressed: () async {
            // await controller
            //     .updateCommunity(
            //         widget.community.communityId ?? "",
            //         widget.community.avatarImage,
            //         _displayNameController.text,
            //         _descriptionController.text,
            //         controller
            //             .getSelectedCategory(),
            //         communityType == CommunityType.public ? true : false);

            //edit profile
            // await Provider.of<CommunityVM>(context, listen: false)
            //     .editCurrentUserInfo(
            //         displayName: _displayNameController.text,
            //         description: _descriptionController.text);
          },
          child: Text(
            "Save",
            style: theme.textTheme.button!.copyWith(
                color: theme.primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
    final bheight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppBar.preferredSize.height;
    return Scaffold(
      appBar: myAppBar,
      body: FadedSlideAnimation(
        // ignore: sort_child_properties_last
        child: Container(
          color: AppColors.white,
          height: bheight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      GestureDetector(
                          onTap: () {
                            // Provider.of<ImagePickerVM>(context, listen: false)
                            //     .showBottomSheet(context);
                          },
                          child: FadedScaleAnimation(
                              child: CircleAvatar(
                            radius: 50,
                            backgroundImage: getImageProvider(
                                widget.community.avatarImage?.fileUrl),
                          ))),
                      Positioned(
                        right: 0,
                        top: 7,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.lightgray,
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
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                      alignment: Alignment.centerLeft,
                      color: AppColors.lightgray,
                      width: double.infinity,
                      child: Text(
                        "Community Info",
                        style: theme.textTheme.headline6!.copyWith(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // Container(
                    //   color: Colors.white,
                    //   width: double.infinity,
                    //   padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    //   child: TextField(
                    //     enabled: false,
                    //     controller:
                    //         TextEditingController(text: ""),//vm.amityUser.userId),
                    //     decoration: InputDecoration(
                    //       labelText: "Community Name",
                    //       labelStyle: TextStyle(height: 1),
                    //       border: InputBorder.none,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: TextField(
                        controller: _displayNameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          alignLabelWithHint: false,
                          border: InputBorder.none,
                          labelStyle: TextStyle(height: 1),
                        ),
                        style: AppTextStyle.activityNameText
                            .copyWith(fontSize: 18),
                      ),
                    ),
                    Divider(
                      color: AppColors.lightgray,
                      thickness: 3,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: "Description",
                          alignLabelWithHint: false,
                          border: InputBorder.none,
                          labelStyle: TextStyle(height: 1),
                        ),
                        style: AppTextStyle.activityNameText
                            .copyWith(fontSize: 18),
                      ),
                    ),
                    Divider(
                      color: AppColors.lightgray,
                      thickness: 3,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: TextField(
                        controller: _categoryController,
                        readOnly: true,
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => CategoryList(
                          //         widget.community, _categoryController)));
                        },
                        decoration: InputDecoration(
                          labelText: "Category",
                          alignLabelWithHint: false,
                          border: InputBorder.none,
                          labelStyle: TextStyle(height: 1),
                        ),
                        style: AppTextStyle.activityNameText
                            .copyWith(fontSize: 18),
                      ),
                    ),
                    Divider(
                      color: AppColors.lightgray,
                      thickness: 3,
                    ),
                    Column(
                      children: [
                        ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.circle),
                            child: Icon(Icons.public),
                          ),
                          title: const Text('Public'),
                          subtitle: const Text(
                              'Anyone can join, view and search this community'),
                          trailing: Radio(
                            value: CommunityType.public,
                            activeColor: theme.primaryColor,
                            groupValue: communityType,
                            onChanged: (CommunityType? value) {
                              setState(() {
                                communityType = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.circle),
                            child: Icon(Icons.lock),
                          ),
                          title: const Text('Private'),
                          subtitle: const Text(
                              'Only members invited by the moderators can join, view and search this community'),
                          trailing: Radio(
                            value: CommunityType.private,
                            activeColor: theme.primaryColor,
                            groupValue: communityType,
                            onChanged: (CommunityType? value) {
                              setState(() {
                                communityType = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}

getImageProvider(String? url) {
  if (url != null) {
    return NetworkImage(url);
  } else {
    return AssetImage("assets/images/user_placeholder.png");
  }
}
