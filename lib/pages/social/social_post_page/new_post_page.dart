import 'package:animation_wrappers/animations/fade_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:dogs_park/pages/social/components/video_player.dart';
import 'package:dogs_park/pages/social/controller/create_post_controller.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/theme/images.dart';
import 'package:dogs_park/utils/networking.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

// final TextEditingController textEditingController =
//     TextEditingController(text: "");

class _NewPostScreenState extends State<NewPostScreen> {
  NewPostController newPostCtrl = NewPostController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newPostCtrl.initialize();
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
    return Scaffold(
      appBar: myAppbar,
      body: SafeArea(
          child: SingleChildScrollView(
        child: FadedSlideAnimation(
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: Container(
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
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                        () => TextField(
                          controller: newPostCtrl.textEditingController.value,
                          scrollPhysics: NeverScrollableScrollPhysics(),
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Write Something To Post",
                          ),
                          style: AppTextStyle.daycareConfirmInfo1
                              .copyWith(color: Colors.grey),
                        ),
                      ),
                      Obx(() => newPostCtrl.amityImageLength > 0
                          ? Container(
                              height: 300,
                              child: GridView.count(
                                crossAxisSpacing: 10,
                                crossAxisCount: 4,
                                children: newPostCtrl.amityImages
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
                      Obx(() => (newPostCtrl.isVideoChosen.value)
                          ? (newPostCtrl.amityVideo.isComplete)
                              ? LocalVideoPlayer(
                                  file: newPostCtrl.amityVideo.file!,
                                )
                              : CircularProgressIndicator()
                          : Container()),
                      // Obx(
                      //   () => (newPostCtrl.amityVideo.value != null &&
                      //           newPostCtrl.amityVideo.value.isBlank == true)
                      //       ? ((newPostCtrl.amityVideo!.value.isComplete)
                      //           ? LocalVideoPlayer(
                      //               file: newPostCtrl.amityVideo!.value.file!,
                      //             )
                      //           : CircularProgressIndicator())
                      //       : const SizedBox(),
                      // ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await newPostCtrl.addVideo();
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
                        await newPostCtrl.addFiles();
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
                        await newPostCtrl.addFileFromCamera();
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
                    await newPostCtrl.createPost(context);

                    print('Create text');
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
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
