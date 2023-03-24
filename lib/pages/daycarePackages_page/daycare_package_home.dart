import 'package:dogs_park/models/daycare_package.dart';
import 'package:dogs_park/pages/daycarePackages_page/components/package.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../../widgets/text_style.dart';

class DaycarePackageHome extends StatefulWidget {
  const DaycarePackageHome({Key? key}) : super(key: key);

  @override
  State<DaycarePackageHome> createState() => _DaycarePackageHomeState();
}

class _DaycarePackageHomeState extends State<DaycarePackageHome> {
  List<Color> colors = [AppColors.primary, AppColors.orange, AppColors.purple];
  @override
  Widget build(BuildContext context) {
    var packageList = PackageList().packageList;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.maxWidth_005),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 50),
                  child: Text('Daycare Packages',
                      style: AppTextStyle.daycarePackagesText),
                ),
                for (int i = 0; i < packageList.length; i++)
                  Package(
                    packageName: packageList[i].name,
                    packageColor: colors[i],
                    packagePrice: packageList[i].price,
                    packageIcon: const Icon(Icons.play_arrow_outlined,
                        color: AppColors.white),
                    idService: (packageList[i].id - 1),
                    videoUrl: 'https://www.youtube.com/watch?v=yX71aXkxaWc',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
