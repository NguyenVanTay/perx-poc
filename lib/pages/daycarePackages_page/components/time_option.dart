import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';

class TimeOption extends StatelessWidget {
  String time;
  bool canChoose;
  bool isSelected;
  TimeOption(
      {Key? key,
      required this.time,
      required this.canChoose,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    Color textColor = AppColors.primary;
    Color backgroundColor = AppColors.white;
    if (canChoose == false) {
      textColor = AppColors.grey;
      backgroundColor = AppColors.white;
    } else {
      if (isSelected) {
        textColor = AppColors.white;
        backgroundColor = AppColors.primary;
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(14.5),
        ),
        border: Border.all(color: canChoose ? AppColors.primary : textColor),
      ),
      margin: const EdgeInsets.only(right: 8, top: 13, left: 0),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Text(
        time,
        style: TextStyle(
            color: textColor, fontSize: 13.0, fontWeight: FontWeight.w400),
      ),
    );
  }
}
