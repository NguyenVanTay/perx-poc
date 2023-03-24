import 'package:animation_wrappers/animations/fade_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:dogs_park/pages/social/controller/create_post_controller.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/theme/images.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CreatePostCommunityScreen extends StatefulWidget {
  String? communityID;
  BuildContext? context;
  CreatePostCommunityScreen({super.key, this.communityID, this.context});

  @override
  State<CreatePostCommunityScreen> createState() =>
      _CreatePostCommunityScreenState();
}

class _CreatePostCommunityScreenState extends State<CreatePostCommunityScreen> {
  NewPostController controller = NewPostController();
  @override
  void initState() {
    // TODO: implement initState
    controller.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final myAppbar = AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: Text('Create Post',
          style:
              theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.w500)),
      leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          color: theme.indicatorColor,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
    final bheight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppbar.preferredSize.height;
    return Scaffold(
      appBar: myAppbar,
      body: SafeArea(
        child: FadedSlideAnimation(
          // ignore: sort_child_properties_last
          child: Container(
            // height: bheight,
            color: AppColors.white,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircleAvatar(
                          radius: Dimens.radius_8,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage(Images.defaultAvatarImage)),
                    )),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          controller: controller.textEditingController.value,
                          scrollPhysics: NeverScrollableScrollPhysics(),
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Write Something To Post",
                          ),
                          style: AppTextStyle.activityNameText
                              .copyWith(fontSize: 18),
                        ),
                        Obx(() => controller.amityImageLength > 0
                            ? Container(
                                height: 300,
                                child: GridView.count(
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 4,
                                  children: controller.amityImages
                                      .map((e) => Container(
                                            child: Image.network(
                                              e.fileInfo!.fileUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ))
                                      .toList(),
                                ),
                              )
                            : const SizedBox()),
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: controller.amityImages.length,
                          itemBuilder: (_, i) {
                            return (controller.amityImages[i].isComplete)
                                ? FadeAnimation(
                                    child: Container(
                                        child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.network(
                                          controller
                                              .amityImages[i].fileInfo!.fileUrl,
                                          fit: BoxFit.cover,
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                                onTap: () {
                                                  controller.deleteImageAt(
                                                      index: i);
                                                },
                                                child: Icon(
                                                  Icons.cancel,
                                                  color: Colors.grey.shade100,
                                                ))),
                                      ],
                                    )),
                                  )
                                : FadeAnimation(
                                    child: Container(
                                      color: theme.highlightColor,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                  );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await controller.addVideo();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.amity_lightGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.fromLTRB(5, 0, 10, 5),
                        child: FaIcon(
                          FontAwesomeIcons.video,
                          color: AppColors.primary,
                          size: 20.0,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await controller.addFiles();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.amity_lightGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.fromLTRB(5, 0, 10, 5),
                        child: Icon(
                          Icons.photo,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await controller.addFileFromCamera();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.amity_lightGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.fromLTRB(5, 0, 10, 5),
                        child: const Icon(
                          Icons.camera_alt,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    if (widget.communityID == null) {
                      //creat post in user Timeline
                      await controller.createPost(context);
                    } else {
                      //create post in Community
                      await controller.createPost(widget.context!,
                          communityId: widget.communityID);
                    }

                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Submit Post",
                      style: theme.textTheme.button,
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
      ),
    );
  }
}
