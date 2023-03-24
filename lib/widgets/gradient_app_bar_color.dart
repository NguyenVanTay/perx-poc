import 'package:dogs_park/theme/colors.dart';
import 'package:flutter/material.dart';

class GradientAppBarColor extends StatelessWidget {
  const GradientAppBarColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            AppColors.white,
            AppColors.white,
          ], // red to yellow
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
    );
  }
}
