// ignore_for_file: must_be_immutable

import 'package:dogs_park/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/dimens.dart';

// ignore: camel_case_types
class CustomTextField_Obscure extends StatefulWidget {
  String fieldName;
  TextEditingController controllerName;
  CustomTextField_Obscure(
      {Key? key, this.fieldName = "", required this.controllerName})
      : super(key: key);

  @override
  State<CustomTextField_Obscure> createState() =>
      _CustomTextField_ObscureState();
}

class _CustomTextField_ObscureState extends State<CustomTextField_Obscure> {
  final _isObscure = true.obs;

  @override
  Widget build(BuildContext context) {
    String fieldName = widget.fieldName;
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
          child: Obx(
            () => TextFormField(
              controller: controllername,
              style: const TextStyle(color: AppColors.black),
              obscureText: _isObscure.value,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: fieldName,
                labelStyle: Theme.of(context).textTheme.titleSmall,
                suffixIcon: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(
                    _isObscure.value ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    _isObscure.value = !_isObscure.value;
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
