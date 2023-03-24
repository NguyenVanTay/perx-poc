import 'package:amity_sdk/amity_sdk.dart';
import 'package:dogs_park/pages/social/controller/post_controller.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Comment extends StatefulWidget {
  double widthConstraint;
  String postId;
  Comment({required this.widthConstraint, required this.postId, Key? key})
      : super(key: key);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  PostController controller = PostController();
  final _commentTextEditController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    controller.listenForComments(widget.postId);
    super.initState();
  }

  bool isLiked(AsyncSnapshot<AmityComment> snapshot) {
    var comments = snapshot.data!;
    if (comments.myReactions != null) {
      return comments.myReactions!.isNotEmpty;
    } else {
      return false;
    }
  }

  //RxBool isLiked = false.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.amityComments.length,
            itemBuilder: ((context, index) {
              return StreamBuilder<AmityComment>(
                key: Key(controller.amityComments[index].commentId!),
                stream: controller.amityComments[index].listen,
                initialData: controller.amityComments[index],
                builder: (context, snapshot) {
                  var comments = snapshot.data!;

                  var commentData = snapshot.data!.data as CommentTextData;
                  String timeDiff = "";
                  Duration diffDuration =
                      DateTime.now().difference(comments.createdAt!);
                  if (diffDuration.inDays > 0) {
                    timeDiff = diffDuration.inDays.toString() + " days ago";
                  } else if (diffDuration.inHours > 0) {
                    timeDiff = diffDuration.inHours.toString() + " hours ago";
                  } else if (diffDuration.inMinutes > 0) {
                    timeDiff =
                        diffDuration.inMinutes.toString() + " minutes ago";
                  } else {
                    timeDiff =
                        diffDuration.inSeconds.toString() + " seconds ago";
                  }
                  if (comments.isDeleted == false) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 4.0),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                            width: 40,
                            height: 40,
                            child: CircleAvatar(
                                radius: Dimens.radius_8,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    AssetImage("images/bully.jpg")),
                            //TODO: replace with avatar
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onLongPress: () {
                                  _showBottomSheet(
                                      context, controller.amityComments[index]);
                                },
                                child: Container(
                                  // width: commentWidth,
                                  width: widget.widthConstraint,
                                  margin: EdgeInsets.only(left: 8.0),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 1,
                                      color: Color(0xffEFEFF4),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        comments.user!.displayName!,
                                        style: TextStyle(
                                            fontFamily: "SF Pro Display",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        commentData.text!,
                                        maxLines: 10,
                                        style: TextStyle(
                                            fontFamily: "SF Pro Display",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: widget.widthConstraint * 0.05),
                                child: Row(
                                  children: [
                                    Text(
                                      // DateFormat.yMMMMEEEEd()
                                      //     .format(comments.createdAt!
                                      //     )
                                      timeDiff,
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(width: 15),
                                    isLiked(snapshot)
                                        ? GestureDetector(
                                            onTap: () {
                                              controller.removeCommentReaction(
                                                  comments);
                                            },
                                            child: Text(
                                              'Like',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.lightBlue),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              controller
                                                  .addCommentReaction(comments);
                                            },
                                            child: Text(
                                              'Like',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff8A8A8F)),
                                            )),
                                    SizedBox(width: 10),
                                    GestureDetector(
                                        onTap: () {
                                          //call api respond acction
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Text(
                                            'Reply',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff8A8A8F)),
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              );
            }),
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 0.8,
                    spreadRadius: 0.5,
                  ),
                ],
                borderRadius: BorderRadius.circular(8)),
            height: 60,
            child: ListTile(
              title: TextField(
                style: TextStyle(color: AppColors.black),
                controller: _commentTextEditController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "write something",
                  hintStyle: TextStyle(fontSize: 14, color: AppColors.black),
                ),
              ),
              trailing: GestureDetector(
                  onTap: () async {
                    await controller.createComment(
                        widget.postId, _commentTextEditController.text);
                    _commentTextEditController.clear();
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: Icon(Icons.send, color: AppColors.primary)),
            ),
          ),
        ],
      ),
    );
  }

  _showBottomSheet(BuildContext context, AmityComment comment) {
    final double mainHeight = MediaQuery.of(context).size.height;
    final double mainWidth = MediaQuery.of(context).size.width;
    Get.bottomSheet(Container(
      color: AppColors.white,
      padding: const EdgeInsets.only(top: 4),
      height: mainHeight * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                print("Edit");
              },
              child: Container(
                height: mainHeight * 0.07,
                width: mainWidth * 0.9,
                //padding: const EdgeInsets.all(Dimens.padding_20),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimens.radiusMaxWidth_009),
                  color: AppColors.primary,
                ),
                child: Center(
                  child: Text(
                    "Edit",
                    style: AppTextStyle.changePassText.copyWith(fontSize: 22),
                  ),
                ),
              )),
          GestureDetector(
              onTap: () {
                controller.deleteomment(comment);
                Get.back();
              },
              child: Container(
                height: mainHeight * 0.07,
                width: mainWidth * 0.9,
                //padding: const EdgeInsets.all(Dimens.padding_20),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimens.radiusMaxWidth_009),
                  color: AppColors.red,
                ),
                child: Center(
                  child: Text(
                    "Delete",
                    style: AppTextStyle.changePassText.copyWith(fontSize: 22),
                  ),
                ),
              )),
          GestureDetector(
              onTap: () {
                Get.back();
                print("Close");
              },
              child: Container(
                height: mainHeight * 0.07,
                width: mainWidth * 0.9,
                //padding: const EdgeInsets.all(Dimens.padding_20),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius:
                      BorderRadius.circular(Dimens.radiusMaxWidth_009),
                  color: AppColors.white,
                ),
                child: Center(
                  child: Text(
                    "Close",
                    style: AppTextStyle.changePassText
                        .copyWith(fontSize: 22, color: AppColors.black),
                  ),
                ),
              )),
        ],
      ),
    ));
  }
}
