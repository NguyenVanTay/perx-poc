import 'package:dogs_park/pages/petDetail_page/components/popUpWidget/body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropdownButton extends StatefulWidget {
  String title;
  List<String> list;
  String currentValue;
  CustomDropdownButton({
    Key? key,
    required this.title,
    required this.list,
    required this.currentValue,
  }) : super(key: key);

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;

    String title = widget.title;
    List<String> list = widget.list;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: const Color(0xFF000000), fontSize: 15),
        ),
        SizedBox(
          width: maxWidth * 0.3,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              alignment: AlignmentDirectional.centerEnd,
              iconSize: 0.0,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              value:
                  (dropdownValue == null) ? widget.currentValue : dropdownValue,
              elevation: 16,
              selectedItemBuilder: (BuildContext context) {
                return list.map<Widget>((String item) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      item,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontSize: 15),
                      maxLines: 1,
                      textAlign: TextAlign.end,
                    ),
                  );
                }).toList();
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class DropDownController extends GetxController {
  RxString dropdownValue = "".obs;
  List<String> controllerList = ['Retrievers (Golden)', 'Boxers', 'Bulldogs'];

  void setSelected(String value) {
    dropdownValue.value = value;
  }
}
