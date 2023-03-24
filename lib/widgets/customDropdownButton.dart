import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  List<String> itemsList;
  String hintText;

  CustomDropdownButton({
    required this.itemsList,
    required this.hintText,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    List<String> itemsList = widget.itemsList;
    String hintText = widget.hintText;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.maxWidth_007, vertical: Dimens.maxHeight_0005),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightgray,
          borderRadius: BorderRadius.circular(Dimens.radius_8),
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: Dimens.padding_20),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  hintText,
                  style: AppTextStyle.titleSmall,
                ),
                value: dropdownValue,
                elevation: 16,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: itemsList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: AppTextStyle.titleSmall,
                    ),
                  );
                }).toList(),
              ),
            )),
      ),
    );
  }
}
