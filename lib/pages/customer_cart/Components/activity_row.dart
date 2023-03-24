import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ActivityRow extends StatelessWidget {
  final String activityName;
  final String activityDescription;
  final double activityPrice;
  const ActivityRow(
      {Key? key,
      required this.activityDescription,
      required this.activityName,
      required this.activityPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  height: Dimens.maxHeight_008,
                  width: Dimens.maxHeight_008,
                  child: const CircleAvatar(
                    radius: Dimens.radius_14,
                    backgroundColor: AppColors.gray,
                    backgroundImage: AssetImage('images/Loc.png'),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activityName,
                    style: AppTextStyle.activityNameText,
                  ),
                  Text(
                    activityDescription,
                    style: AppTextStyle.activityDescriptionText,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              "\$${activityPrice.toInt()}",
              style: AppTextStyle.activityNameText,
            ),
          )
        ],
      ),
    );
  }
}
