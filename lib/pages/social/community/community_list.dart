import 'package:amity_sdk/amity_sdk.dart';
import 'package:animation_wrappers/animations/fade_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:dogs_park/pages/social/community/community_controller.dart';
import 'package:dogs_park/pages/social/community/community_feed_screen.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CommunityList extends StatefulWidget {
  CommunityListType communityType;

  CommunityList(this.communityType);
  @override
  _CommunityListState createState() => _CommunityListState();
}

CommunityController controller = CommunityController();

class _CommunityListState extends State<CommunityList> {
  CommunityListType communityType = CommunityListType.recommend;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    communityType = widget.communityType;
    Future.delayed(Duration.zero, () {
      switch (communityType) {
        case CommunityListType.my:
          controller.initAmityMyCommunityList();
          break;
        case CommunityListType.recommend:
          controller.initAmityRecommendCommunityList();
          break;
        case CommunityListType.trending:
          controller.initAmityTrendingCommunityList();
          break;
        default:
          controller.initAmityMyCommunityList();
          break;
      }
    });
    super.initState();
  }

  List<AmityCommunity> getList() {
    switch (communityType) {
      case CommunityListType.my:
        return controller.getAmityMyCommunities();

      case CommunityListType.recommend:
        return controller.getAmityRecommendCommunities();

      case CommunityListType.trending:
        return controller.getAmityTrendingCommunities();

      default:
        return [];
    }
  }

  int getLength() {
    switch (communityType) {
      case CommunityListType.my:
        return controller.getAmityMyCommunities().length;

      case CommunityListType.recommend:
        return controller.getAmityRecommendCommunities().length;

      case CommunityListType.trending:
        return controller.getAmityTrendingCommunities().length;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        AppBar().preferredSize.height;
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: Container(
            height: bHeight,
            color: Color(0xfff1f1f1),
            child: FadedSlideAnimation(
              // ignore: sort_child_properties_last
              child: getLength() < 1
                  // ignore: prefer_const_constructors
                  ? Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary),
                    )
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: getLength(),
                      itemBuilder: (context, index) {
                        return StreamBuilder<AmityCommunity>(
                            stream: getList()[index].listen,
                            initialData: getList()[index],
                            builder: (context, snapshot) {
                              return CommunityWidget(
                                community: snapshot.data!,
                                theme: theme,
                                communityType: communityType,
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
    );
  }
}

class CommunityWidget extends StatelessWidget {
  const CommunityWidget(
      {Key? key,
      required this.community,
      required this.theme,
      required this.communityType})
      : super(key: key);

  final AmityCommunity community;
  final ThemeData theme;
  final CommunityListType communityType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // await Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => ChangeNotifierProvider(
        //           create: (context) => CommuFeedVM(),
        //           child: CommunityScreen(
        //             community: community,
        //           ),
        //         )));
        Get.to(CommunityScreen(
          community: community,
        ));
        switch (communityType) {
          case CommunityListType.my:
            controller.initAmityMyCommunityList();
            break;
          case CommunityListType.recommend:
            controller.initAmityRecommendCommunityList();
            break;
          case CommunityListType.trending:
            controller.initAmityTrendingCommunityList();
            break;
          default:
            controller.initAmityMyCommunityList();
            break;
        }
      },
      child: Card(
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: FadeAnimation(
                    child: (community.avatarImage?.fileUrl != null)
                        ? CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                (NetworkImage(community.avatarImage!.fileUrl)))
                        : CircleAvatar(
                            backgroundImage: AssetImage(
                                "assets/images/user_placeholder.png")),
                  ),
                  title: Text(
                    community.displayName ?? "Community",
                    style: theme.textTheme.bodyText1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    " ${community.membersCount} members",
                    style: theme.textTheme.bodyText1!
                        .copyWith(color: AppColors.gray, fontSize: 11),
                  ),
                  trailing: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            theme.primaryColor)),
                    onPressed: () {
                      if (community.isJoined != null) {
                        if (community.isJoined!) {
                          controller.leaveCommunity(community.communityId ?? "",
                              type: communityType);
                        } else {
                          controller.joinCommunity(community.communityId ?? "",
                              type: communityType);
                        }
                      }
                    },
                    child: Text(community.isJoined != null
                        ? (community.isJoined! ? "Leave" : "Join")
                        : "Join"),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
