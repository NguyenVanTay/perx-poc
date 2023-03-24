import 'package:flutter/material.dart';

class CustomRowComponent extends StatefulWidget {
  String title;
  dynamic value;
  bool? enabled;

  CustomRowComponent({
    Key? key,
    required this.title,
    required this.value,
    this.enabled = false,
  }) : super(key: key);

  @override
  State<CustomRowComponent> createState() => _CustomRowComponentState();
}

class _CustomRowComponentState extends State<CustomRowComponent> {
  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;
    final double maxHeight = MediaQuery.of(context).size.height;

    String title = widget.title;
    dynamic value = widget.value;
    bool? enabled = widget.enabled;

    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(left: maxWidth * 0.048),
        child: const Divider(
          height: 1,
          thickness: 1,
          indent: 0,
          endIndent: 0,
          color: Color(0xFFEFEFF4),
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: maxWidth * 0.048, vertical: maxHeight * 0.015),
        width: maxWidth,
        height: maxHeight * (49 / 812),
        child: Row(
          children: [
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: const Color(0xFF000000), fontSize: 15)),
            Expanded(
              child: TextFormField(
                textAlign: TextAlign.end,
                initialValue: value,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontSize: 15),
                decoration: const InputDecoration(border: InputBorder.none),
                enabled: enabled,
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
