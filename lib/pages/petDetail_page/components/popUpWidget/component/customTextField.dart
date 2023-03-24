import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  String title;
  String value;
  TextEditingController controllerName;
  CustomTextField({
    Key? key,
    required this.title,
    required this.value,
    required this.controllerName,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;

    String title = widget.title;
    String value = widget.value;
    TextEditingController controllername = widget.controllerName;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: const Color(0xFF000000), fontSize: 15),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          width: maxWidth * 0.3,
          child: TextFormField(
            textAlign: TextAlign.end,
            initialValue: value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 15,
                  overflow: TextOverflow.ellipsis,
                ),
            decoration: const InputDecoration(border: InputBorder.none),
            enabled: true,
          ),
        )
      ],
    );
  }
}
