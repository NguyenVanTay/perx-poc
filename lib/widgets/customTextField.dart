// ignore: file_names
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';

import '../theme/dimens.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  String fieldName;
  TextEditingController controllerName;
  bool? enabled;
  bool? bold;
  CustomTextField(
      {Key? key,
      this.fieldName = "",
      required this.controllerName,
      this.enabled = false,
      this.bold = true})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    bool? bold = widget.bold;
    String fieldName = widget.fieldName;
    bool? enabled = widget.enabled;
    TextEditingController controllername = widget.controllerName;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.maxWidth_007, vertical: Dimens.maxHeight_0005),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightgray,
          borderRadius: BorderRadius.circular(Dimens.border_8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: Dimens.padding_20),
          child: TextField(
            controller: controllername,
            enabled: enabled,
            style: bold == true
                ? const TextStyle(color: AppColors.black)
                : AppTextStyle.titleSmall,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: fieldName,
              labelStyle: AppTextStyle.titleSmall,
            ),
          ),
        ),
      ),
    );
  }
}
