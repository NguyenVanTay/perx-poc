import 'package:amity_sdk/amity_sdk.dart';
import 'package:animation_wrappers/animations/fade_animation.dart';
import 'package:dogs_park/pages/social/controller/post_controller.dart';
import 'package:dogs_park/pages/social/social_home_page/comment_page.dart';
import 'package:dogs_park/pages/social_pages/components/video_player.dart';
import 'package:dogs_park/pages/social_pages/provider/model/amity_message_model.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/theme/images.dart';
import 'package:dogs_park/widgets/text_style.dart';
// import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class FeedPost extends StatefulWidget {
  final AmityPost post;
  final Function onPostDeleteHandler;
  const FeedPost(
      {required this.post, required this.onPostDeleteHandler, Key? key})
      : super(key: key);

  @override
  State<FeedPost> createState() => _FeedPostState();
}

class _FeedPostState extends State<FeedPost> {
  // static final MAX_ELEMENT_PER_ROW = 4;
  RxInt like = 0.obs;
  RxBool _liked = false.obs;
  RxBool _marked = false.obs;
  RxString videoUrl = "".obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> checkChildrenPostType() async {
    var posts = widget.post.children;
  }

  // PostController postController = PostController();
  @override
  Widget build(BuildContext context) {
    var p = widget.post;

    var user = p.postedUser;
    // print(p);
    like.value = p.reactionCount!;
    String communityName = "";

    _liked.value = p.myReactions!.isNotEmpty;
    _marked.value = p.isFlaggedByMe;

    if (p.targetType == AmityPostTargetType.COMMUNITY) {
      communityName =
          (p.target as CommunityTarget).targetCommunity!.displayName!;
    }
    TextData content = (p.data as TextData);
    List<AmityPost> childrenData = p.children ?? [];
    RxBool hasVideo = false.obs;

    // for (int i = 0; i < childrenData.length; i++) {
    //   print(childrenData[i].data);
    // }
    final double mainWidth = MediaQuery.of(context).size.width;

    late VideoPlayerController videoCtrl;
    return GestureDetector(
      onTap: () {
        print('Post click');
        // Get.to(CommentPage());
      },
      child: Container(
        color: AppColors.white,
        margin: const EdgeInsets.only(top: 10),
        child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(5),
                      leading: FadeAnimation(
                          child: GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                height: mainWidth * 0.13,
                                width: mainWidth * 0.13,
                                child: user?.avatarUrl != null
                                    ? CircleAvatar(
                                        radius: Dimens.radius_8,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(
                                            user?.avatarCustomUrl ?? ""))
                                    : const CircleAvatar(
                                        radius: Dimens.radius_8,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            AssetImage("images/jisoo.jpeg")),
                              ))),
                      title: Wrap(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              p.postedUser!.displayName!,
                              style: AppTextStyle.welcomeText.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Color(0xff1A1B23)),
                            ),
                          ),
                          (communityName != "")
                              ? const Icon(
                                  Icons.arrow_right_rounded,
                                  color: Color(0xff1A1B23),
                                )
                              : const SizedBox(),
                          (communityName != "")
                              ? GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    communityName,
                                    style: AppTextStyle.welcomeText.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Color(0xff1A1B23)),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(p.createdAt!),
                        style: AppTextStyle.welcomeText.copyWith(
                            color: AppColors.amity_textGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            Images.iconShareIcon,
                            scale: 1.1,
                          ),
                          // Icon(
                          //   Icons.share,
                          //   size: Dimens.height_20,
                          //   color: AppColors.primary,
                          // ),
                          SizedBox(width: 7),
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                if (_marked.value) {
                                  PostController().unflagPost(p);
                                } else {
                                  PostController().flagPost(p);
                                }
                                _marked.value = !_marked.value;
                              },
                              child: _marked.value
                                  ? Icon(
                                      Icons.bookmark_rounded,
                                      size: Dimens.height_20,
                                      color: AppColors.primary,
                                    )
                                  : Icon(
                                      Icons.bookmark_rounded,
                                      size: Dimens.height_20,
                                      color: AppColors.amity_grey,
                                    ),
                            ),
                          ),
                          PopupMenuButton<String>(
                            child: Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              const PopupMenuItem<String>(
                                value: 'Delete',
                                child: Text(
                                  'Delete post',
                                  style: AppTextStyle.inputChatText,
                                ),
                              )
                            ],
                            onSelected: (value) async {
                              if (value == 'Delete') {
                                print(value);
                                await p.delete();
                                widget.onPostDeleteHandler.call();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 8),
                      child: Text(
                        content.text!,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "SF Pro Display",
                            color: Color(0xff1A1B23),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: childrenData.map((e) {
                            if (e.type == AmityDataType.IMAGE) {
                              print("E:" + e.toString());
                              ImageData img = e.data as ImageData;
                              // print(img.image.fileUrl);
                              print('Image data: ' + img.toString());
                              return SizedBox(
                                width: mainWidth * 0.87,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    img.image.fileUrl + '?size=large',
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              );
                            } else if (e.type == AmityDataType.VIDEO) {
                              var vi = e.data as VideoData;
                              print("Video: " + vi.toString());
                              // print(e);
                              vi.getVideo(AmityVideoQuality.HIGH).then((value) {
                                print("value video: " + value.toString());
                                print(value.fileUrl);
                                videoUrl.value = value.fileUrl;
                                hasVideo.value = true;
                                return MyVideoPlayer2(
                                    post: e,
                                    url: videoUrl.value,
                                    isInFeed: true,
                                    isEnableVideoTools: false);
                              });
                            }
                            return Container();
                          }).toList(),
                        ),
                      ),
                    ),
                    Obx(() => videoUrl.value != ""
                        ? MyVideoPlayer2(
                            post: widget.post.children![0],
                            url: videoUrl.value,
                            isInFeed: false,
                            isEnableVideoTools: false)
                        : SizedBox()),
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 9, right: 9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => _liked.value
                                      ? Builder(builder: (context) {
                                          return Row(
                                            children: [
                                              // Image(
                                              //   image: AssetImage(Images.iconLikeIcon),
                                              //   height: 21,
                                              //   width: 21,
                                              // ),
                                              Container(
                                                height: mainWidth * 0.05,
                                                width: mainWidth * 0.05,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  color: AppColors.primary,
                                                ),
                                                child: Icon(
                                                  Icons.thumb_up_alt,
                                                  color: AppColors.white,
                                                  size: mainWidth * 0.03,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Obx(
                                                () => Text("$like",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .amity_grey,
                                                        fontSize: 10,
                                                        letterSpacing: 1)),
                                              )
                                            ],
                                          );
                                        })
                                      : SizedBox(),
                                ),
                                Builder(builder: (context) {
                                  // any logic needed...

                                  return p.commentCount! > 0
                                      ? Text(
                                          "${p.commentCount}" + ' comment',
                                          style: TextStyle(
                                              color: AppColors.amity_grey,
                                              fontSize: 10,
                                              letterSpacing: 0.5),
                                        )
                                      : SizedBox();
                                })
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 7, bottom: 7, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(
                                      () => GestureDetector(
                                          onTap: () async {
                                            if (_liked.value == false) {
                                              like++;
                                              await p
                                                  .react()
                                                  .addReaction('like');
                                              _liked.value = true;
                                            } else if (_liked.value == true) {
                                              like--;
                                              _liked.value = false;
                                              await p
                                                  .react()
                                                  .removeReaction('like');
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.thumb_up,
                                                color: _liked.value
                                                    ? AppColors.primary
                                                    : AppColors.gray,
                                                size: 20,
                                              ),
                                              Text(
                                                ' Like',
                                                style: TextStyle(
                                                    color: _liked.value
                                                        ? AppColors.primary
                                                        : AppColors.gray,
                                                    fontSize: 17,
                                                    letterSpacing: 1),
                                              ),
                                            ],
                                          )),
                                    ),
                                    SizedBox(width: 8.5),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             CommentScreen(
                                    //               amityPost: widget.post,
                                    //             )));
                                    print("To comment Page");
                                    Get.to(CommentPage(
                                      post: widget.post,
                                    ));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.chat_bubble,
                                        color: AppColors.gray,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5.5),
                                      Text(
                                        'Comment',
                                        style: TextStyle(
                                            color: AppColors.amity_grey,
                                            fontSize: 17,
                                            letterSpacing: 0.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                      ],
                    )
                  ]),
            )),
      ),
    );
  }
}
