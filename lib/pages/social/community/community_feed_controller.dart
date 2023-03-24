import 'dart:developer';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:dogs_park/pages/social/components/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommuFeedController extends GetxController {
  late String communityID;

  var _amityCommunityFeedPosts = <AmityPost>[].obs;

  late PagingController<AmityPost> _controllerCommu;

  final scrollcontroller = ScrollController();

  List<AmityPost> getCommunityPosts() {
    return _amityCommunityFeedPosts;
  }

  void addPostToFeed(AmityPost post) {
    _controllerCommu.addAtIndex(0, post);
  }

  Future<void> initAmityCommunityFeed(String communityId) async {
    //inititate the PagingController
    _controllerCommu = await PagingController(
      pageFuture: (token) => AmitySocialClient.newFeedRepository()
          .getCommunityFeed(communityId)
          //feedType could be AmityFeedType.PUBLISHED, AmityFeedType.REVIEWING, AmityFeedType.DECLINED
          .feedType(AmityFeedType.PUBLISHED)
          .getPagingData(token: token, limit: 20),
      pageSize: 20,
    )
      ..addListener(
        () async {
          log("communityListener");
          if (_controllerCommu.error == null) {
            //handle results, we suggest to clear the previous items
            //and add with the latest _controller.loadedItems
            _amityCommunityFeedPosts.clear();
            _amityCommunityFeedPosts.addAll(_controllerCommu.loadedItems);
            //update widgets

          } else {
            //error on pagination controller
            await AmityDialog().showAlertErrorDialog(
                title: "Error!", message: _controllerCommu.error.toString());
            //update widgets

          }
        },
      );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controllerCommu.fetchNextPage();
    });

    scrollcontroller.addListener(loadnextpage);

    //inititate the PagingController
    await AmitySocialClient.newFeedRepository()
        .getCommunityFeed(communityId)
        .getPagingData()
        .then((value) {
      _amityCommunityFeedPosts.value = value.data;
    });
  }

  void loadnextpage() {
    if ((scrollcontroller.position.pixels ==
            scrollcontroller.position.maxScrollExtent) &&
        _controllerCommu.hasMoreItems) {
      _controllerCommu.fetchNextPage();
    }
  }
}
