import 'package:animation_wrappers/animations/faded_slide_animation.dart';

import 'package:dogs_park/pages/social/components/feed_post.dart';
import 'package:dogs_park/pages/social/controller/feed_controller.dart';
import 'package:dogs_park/pages/social/social_post_page/new_post_page.dart';

import 'package:dogs_park/theme/colors.dart';

import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../chat/chats_page.dart';

class HomeFeedPage extends StatefulWidget {
  const HomeFeedPage({super.key});

  @override
  State<HomeFeedPage> createState() => _HomeFeedPageState();
}

class _HomeFeedPageState extends State<HomeFeedPage> {
  FeedController feedController = FeedController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    feedController.initAmityGlobalfeed();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: const Text(
            'Social Page',
            style: AppTextStyle.titleLarge,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(ChatsPage());
                },
                icon: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.lightgray),
                  child: const Icon(
                    Icons.message,
                    size: 20,
                    color: AppColors.primary,
                  ),
                ))
          ],
        ),
        body: RefreshIndicator(
          color: theme.primaryColor,
          onRefresh: () async {
            // Replace this delay with the code to be executed during refresh
            // and return a Future when code finishs execution.
            await feedController.initAmityGlobalfeed();
          },
          child: FadedSlideAnimation(
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
            child: Obx(() => feedController.postLength.value >= 0
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: feedController.getAmityPosts().map((e) {
                      print("Length: " +
                          feedController.getAmityPosts().length.toString());
                      return FeedPost(
                        post: e,
                        onPostDeleteHandler: () async {
                          await feedController.initAmityGlobalfeed();
                          // feedController.deletePost(e, postIndex)
                        },
                      );
                    }).toList(),
                  )
                : const SizedBox()),
          ),
        ),
        floatingActionButton: SizedBox(
          height: 40,
          width: 40,
          child: FittedBox(
            child: FloatingActionButton(
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NewPostScreen()));
                }),
          ),
        ),
      ),
    );
  }
}
