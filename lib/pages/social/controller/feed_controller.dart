import 'dart:developer';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:dogs_park/pages/social/components/alert_dialog.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../../social_pages/utils/navigation_key.dart';

enum Feedtype { GLOBAL, COOMU }

class FeedController extends GetxController {
  RxInt postLength = 0.obs;
  var _amityGlobalFeedPosts = <AmityPost>[];

  late PagingController<AmityPost> _controllerGlobal;

  final scrollcontroller = ScrollController();

  bool loadingNexPage = false;
  var isshowDialog = kDebugMode;

  Future<void> showAlertErrorDialog(
      {required String title, required String message}) async {
    await FirebaseCrashlytics.instance
        .recordError(title, StackTrace.current, reason: message);

    bool isbarrierDismissible() {
      if (title.toLowerCase().contains("error")) {
        return true;
      } else {
        return false;
      }
    }

    if (isshowDialog) {
      await showDialog(
        barrierDismissible: isbarrierDismissible(),
        context: NavigationService.navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }
  }
  List<AmityPost> getAmityPosts() {
    postLength.value = _amityGlobalFeedPosts.length;
    return _amityGlobalFeedPosts;
  }

  Future<void> addPostToFeed(AmityPost post) async {
    _controllerGlobal.addAtIndex(0, post);
    //notifyListeners();
  }

  Future<void> initAmityGlobalfeed() async {
    _controllerGlobal = PagingController(
      pageFuture: (token) => AmitySocialClient.newFeedRepository()
          .getGlobalFeed()
          .getPagingData(token: token, limit: 20),
      pageSize: 20,
    )..addListener(
          () async {
        if (_controllerGlobal.error == null) {
          _amityGlobalFeedPosts.clear();
          _amityGlobalFeedPosts.addAll(_controllerGlobal.loadedItems);
          postLength.value = _amityGlobalFeedPosts.length;
        } else {
          //Error on pagination controller
          showAlertErrorDialog(
              title: "Error!", message: _controllerGlobal.error.toString());
        }
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controllerGlobal.fetchNextPage();
    });
    scrollcontroller.removeListener(() {});
    scrollcontroller.addListener(loadnextpage);

    //inititate the PagingController
    await AmitySocialClient.newFeedRepository()
        .getGlobalFeed()
        .getPagingData()
        .then((value) async {
      _amityGlobalFeedPosts = value.data;
      if (_amityGlobalFeedPosts.isEmpty) {
        showAlertErrorDialog(
            title: "No Post yet!",
            message: "please join some community or follow some user 🥳");
      }
    }).onError(
          (error, stackTrace) async {
        showAlertErrorDialog(title: "Error!", message: error.toString());
      },
    );
    //notifyListeners();
  }

  void loadnextpage() async {
    // log(scrollcontroller.offset);
    if ((scrollcontroller.position.pixels >
        scrollcontroller.position.maxScrollExtent - 800) &&
        _controllerGlobal.hasMoreItems &&
        !loadingNexPage) {
      loadingNexPage = true;
      //notifyListeners();
      log("loading Next Page...");
      await _controllerGlobal.fetchNextPage().then((value) {
        loadingNexPage = false;
        //notifyListeners();
      });
    }
  }
}