import 'package:flutter/material.dart';
import 'package:dogs_park/theme/colors.dart';
import '../generated/l10n.dart';
import '../post/upload/upload_gallery.dart';
import '../post/upload/upload_photo.dart';
import '../post/upload/upload_video.dart';

class UploadScreen extends StatefulWidget {
  @override
  UploadScreenState createState() => UploadScreenState();
}

class UploadScreenState extends State<UploadScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    _tabController!.addListener(() {
      setState(() {
        _selectedIndex = _tabController!.index;
      });
    });
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final bHeight = mediaQuery.size.height - mediaQuery.padding.top;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: mediaQuery.orientation == Orientation.portrait
                  ? bHeight * 0.02
                  : bHeight * 0.05,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.close, color: AppColors.black),
              ),
            ),
            Column(
              children: [
                Container(
                  height: mediaQuery.orientation == Orientation.portrait
                      ? bHeight * 0.07
                      : bHeight * 0.15,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: theme.primaryColor,
                    tabs: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          S.of(context).photo,
                          style: theme.textTheme.headline6!.copyWith(
                            color: _selectedIndex == 0
                                ? theme.primaryColor
                                : AppColors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          S.of(context).video,
                          style: theme.textTheme.headline6!.copyWith(
                            color: _selectedIndex == 1
                                ? theme.primaryColor
                                : AppColors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          S.of(context).gallery,
                          style: theme.textTheme.headline6!.copyWith(
                            color: _selectedIndex == 2
                                ? theme.primaryColor
                                : AppColors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  // height: mediaQuery.orientation == Orientation.portrait
                  //     ? bHeight * 0.93
                  //     : bHeight * 0.85,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      UploadPhotoTab(),
                      UploadVideoTab(),
                      UploadGalleryTab(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
