import 'package:animation_wrappers/animations/fade_animation.dart';
import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:dogs_park/pages/social/social_notification_page/components/notification_detail_page.dart';
import 'package:dogs_park/routes/app_routes.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: const TabBar(
            physics: BouncingScrollPhysics(),
            isScrollable: true,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.black,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: "All"),
              Tab(text: "Likes"),
              Tab(text: " Comments"),
            ],
          ),
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            children: [
              NotificationDetail(
                content: "Liked",
              ),
              NotificationDetail(
                content: "Liked",
              ),
              NotificationDetail(
                content: "Commented",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
