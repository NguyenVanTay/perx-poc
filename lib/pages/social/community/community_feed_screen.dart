import 'dart:developer';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:dogs_park/pages/social/community/community_controller.dart';
import 'package:dogs_park/pages/social/community/community_feed_controller.dart';
import 'package:dogs_park/pages/social/community/create_post_community_screen.dart';
import 'package:dogs_park/pages/social/community/edit_community.dart';
import 'package:dogs_park/pages/social/components/feed_post.dart';
import 'package:dogs_park/pages/social_pages/app_navigation/home/home_following_screen.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class CommunityScreen extends StatefulWidget {
  final AmityCommunity community;
  final bool isFromFeed;
  const CommunityScreen(
      {Key? key, required this.community, this.isFromFeed = false})
      : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

CommuFeedController controller = Get.put(CommuFeedController());

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.initAmityCommunityFeed(widget.community.communityId!);
  }

  getAvatarImage(String? url) {
    if (url != null) {
      return NetworkImage(url);
    } else {
      return AssetImage("images/user_placeholder.png");
    }
  }

  Widget communityDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.community.description == null
            ? Container()
            : Text(
                "About",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
        SizedBox(
          height: 5.0,
        ),
        Text(widget.community.description ?? ""),
      ],
    );
  }

  void onCommunityOptionTap(CommunityFeedMenuOption option) {
    switch (option) {
      case CommunityFeedMenuOption.edit:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditCommunityScreen(widget.community)));
        break;
      case CommunityFeedMenuOption.members:
        break;
      default:
    }
  }

  Widget communityInfo() {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            Text(
                widget.community.displayName != null
                    ? widget.community.displayName!
                    : "Community",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            Spacer(),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            ListTile(
                              leading: Icon(Icons.edit),
                              title: Text(
                                'Edit Community',
                                style: AppTextStyle.daycarePrice,
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                                onCommunityOptionTap(
                                    CommunityFeedMenuOption.edit);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.people_alt_rounded),
                              title: Text('Members',
                                  style: AppTextStyle.daycarePrice),
                              onTap: () {
                                onCommunityOptionTap(
                                    CommunityFeedMenuOption.members);
                              },
                            ),
                            ListTile(
                              title: Text(''),
                            ),
                          ],
                        );
                      });
                },
                icon: Icon(Icons.more_horiz_rounded, color: Colors.black)),
          ],
        ),
        Row(
          children: [
            Icon(Icons.public_rounded, color: Colors.black),
            SizedBox(
              width: 5,
            ),
            Text(widget.community.isPublic != null
                ? (widget.community.isPublic! ? "Public" : "Private")
                : "N/A"),
            SizedBox(
              width: 20,
            ),
            Text("${widget.community.membersCount} members"),
            Spacer(),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(theme.primaryColor)),
              onPressed: () {
                if (widget.community.isJoined != null) {
                  if (widget.community.isJoined!) {
                    AmitySocialClient.newCommunityRepository()
                        .leaveCommunity(widget.community.communityId!)
                        .then((value) {
                      setState(() {
                        widget.community.isJoined =
                            !(widget.community.isJoined!);
                      });
                    }).onError((error, stackTrace) {
                      //handle error
                      log(error.toString());
                    });
                  } else {
                    AmitySocialClient.newCommunityRepository()
                        .joinCommunity(widget.community.communityId!)
                        .then((value) {
                      setState(() {
                        widget.community.isJoined =
                            !(widget.community.isJoined!);
                      });
                    }).onError((error, stackTrace) {
                      log(error.toString());
                    });
                  }
                }
              },
              child: Text(widget.community.isJoined != null
                  ? (widget.community.isJoined! ? "Leave" : "Join")
                  : "N/A"),
            )
          ],
        )
      ],
    );
  }

  Widget communityDetailSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: OptimizedCacheImage(
                height: 400,
                imageUrl: widget.community.avatarImage?.fileUrl != null
                    ? widget.community.avatarImage!.fileUrl + "?size=full"
                    : "https://f8n-ipfs-production.imgix.net/QmXydmx66BwUCLXsxa2q6Z9ATKht6fbXqdrxU8VFd6c4cD/nft.png?q=80&auto=format%2Ccompress&cs=srgb&max-w=1680&max-h=1680",
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 400,
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [communityInfo(), Divider(), communityDescription()],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final bHeight = mediaQuery.size.height - mediaQuery.padding.top;
    return Scaffold(
      floatingActionButton: (widget.community.isJoined!)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context2) => CreatePostCommunityScreen(
                          communityID: widget.community.communityId,
                          context: context,
                        )));
              },
              backgroundColor: theme.primaryColor,
              child: Icon(Icons.add),
            )
          : null,
      backgroundColor: AppColors.lightgray,
      body: FadedSlideAnimation(
        // ignore: sort_child_properties_last
        child: SafeArea(
          child: SingleChildScrollView(
            controller: controller.scrollcontroller,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon:
                        Icon(Icons.chevron_left, color: Colors.black, size: 35),
                  ),
                ),
                Container(
                    width: double.infinity,
                    // height: (bHeight - 120) * 0.4,
                    child: communityDetailSection()),
                Container(
                  child: Obx(
                    () => FadedSlideAnimation(
                      // ignore: sort_child_properties_last
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.getCommunityPosts().length,
                        itemBuilder: (context, index) {
                          return StreamBuilder<AmityPost>(
                              key: Key(controller
                                  .getCommunityPosts()[index]
                                  .postId!),
                              stream:
                                  controller.getCommunityPosts()[index].listen,
                              initialData:
                                  controller.getCommunityPosts()[index],
                              builder: (context, snapshot) {
                                // return PostWidget(
                                //   post: snapshot.data!,
                                //   theme: theme,
                                //   postIndex: index,
                                // );
                                return FeedPost(
                                  post: snapshot.data!,
                                  onPostDeleteHandler: () async {
                                    await controller.initAmityCommunityFeed(
                                        widget.community.communityId!);
                                    // feedController.deletePost(e, postIndex)
                                  },
                                );
                              });
                        },
                      ),
                      beginOffset: Offset(0, 0.3),
                      endOffset: Offset(0, 0),
                      slideCurve: Curves.linearToEaseOut,
                    ),
                  ),
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
