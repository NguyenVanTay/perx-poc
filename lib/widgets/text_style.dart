import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/dimens.dart';

mixin AppTextStyle {
  static const titleAppBarStyle = TextStyle(
    color: AppColors.black,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w600,
  );
  static const changePassText = TextStyle(
    fontSize: Dimens.textSize_16,
    color: AppColors.white,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.bold,
  );
  static const signOutText = TextStyle(
    fontSize: Dimens.textSize_16,
    color: AppColors.primary,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.bold,
  );
  static const titleLarge = TextStyle(
      fontSize: Dimens.textSize_40,
      color: AppColors.black,
      fontWeight: FontWeight.w700,
      fontFamily: Dimens.fontFamily);
  static const titleMedium = TextStyle(
    fontSize: Dimens.textSize_17,
    color: AppColors.white,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w600,
  );
  static const titleSmall = TextStyle(
    fontSize: Dimens.textSize_17,
    color: AppColors.gray,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w400,
  );
  static TextStyle welcomeText = TextStyle(
    fontSize: Dimens.maxWidth_012,
    color: AppColors.black,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w700,
  );
  //---daycare package page---
  static TextStyle daycarePackagesText = titleMedium.copyWith(
    fontSize: Dimens.textSize_34,
    color: AppColors.black,
  );

  static TextStyle option_selected = titleMedium.copyWith(
    color: AppColors.black,
  );
  static TextStyle option_unselected = titleSmall.copyWith(
    color: AppColors.darkgray,
  );
  static TextStyle daycareHeader = option_selected;
  static const TextStyle daycarePrice = TextStyle(
    fontSize: Dimens.textSize_15,
    color: AppColors.black,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle daycareConfirmInfo1 = TextStyle(
    fontSize: Dimens.textSize_17,
    color: AppColors.black,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle daycareSelection = TextStyle(
    fontFamily: Dimens.fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );
  static const TextStyle daycareConfirmInfo2 = TextStyle(
    fontSize: 13.0,
    color: AppColors.black,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle daycareConfirmInfo3 = TextStyle(
    fontSize: 13.0,
    color: AppColors.black,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle daycareTextField1 = TextStyle(
    fontSize: 15.0,
    color: AppColors.black,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle daycarePackageName = TextStyle(
    fontSize: 24.0,
    color: AppColors.white,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle daycareInformation = TextStyle(
    fontSize: 14.0,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w500,
  );
  static const daycareHeader2 = TextStyle(
    fontSize: 14.0,
    color: AppColors.gray,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w400,
  );
  static const weekdayStyle = TextStyle(
    fontSize: 10.0,
    color: AppColors.black,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w400,
  );
  static const weekendStyle = TextStyle(
    fontSize: 10.0,
    color: AppColors.gray,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w400,
  );
  static const titleCalendar = TextStyle(
    fontSize: 17.0,
    color: AppColors.black,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w400,
  );

  //---end daycare package style---
  static const TextStyle period_option = TextStyle(
    fontSize: Dimens.textSize_15,
    color: AppColors.black,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w400,
  );

  static const continueSighInText = TextStyle(
    fontSize: Dimens.textSize_17,
    color: AppColors.darkgray,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w400,
  );
  static const remenberMeText = TextStyle(
    fontSize: Dimens.textSize_15,
    color: AppColors.darkgray,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w400,
  );
  static const forgotPassText = TextStyle(
    fontSize: Dimens.textSize_15,
    color: AppColors.gray,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w400,
  );
  static const notHaveAccountText = TextStyle(
    fontSize: Dimens.textSize_17,
    color: AppColors.darkgray,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w400,
  );
  static const signUpText = TextStyle(
    fontSize: Dimens.textSize_17,
    color: AppColors.black,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w500,
  );
  static const dogNameInCartText = TextStyle(
    fontSize: Dimens.textSize_28,
    color: AppColors.white,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w600,
  );
  static const packageInCartText = TextStyle(
    fontSize: Dimens.textSize_15,
    color: AppColors.white,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w600,
  );
  static const checkTextInCartText = TextStyle(
    fontSize: Dimens.textSize_13,
    color: AppColors.white,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w400,
  );
  static const activityInCartText = TextStyle(
    fontSize: Dimens.textSize_28,
    color: AppColors.primary,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w500,
  );
  static const activityNameText = TextStyle(
    fontSize: Dimens.textSize_15,
    color: AppColors.black,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w500,
  );
  static const activityDescriptionText = TextStyle(
    fontSize: Dimens.textSize_13,
    color: AppColors.gray,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w400,
  );
  //chat_page
  static const chatTitle = TextStyle(
    fontSize: Dimens.textSize_15,
    color: AppColors.black,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w600,
  );
  static final chatHistoryText = TextStyle(
    fontSize: Dimens.textSize_13,
    color: Colors.grey.shade500,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w400,
  );
  static final chatCurrentText = TextStyle(
    fontSize: Dimens.textSize_13,
    color: Colors.grey.shade600,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.w400,
  );
  static const inputChatText = TextStyle(
    fontSize: 14,
    color: AppColors.black,
    fontFamily: Dimens.fontFamily,
    fontWeight: FontWeight.normal,
  );
}
