import 'package:flutter/material.dart';

class CustomDropdownRow extends StatefulWidget {
  String title;
  List<Widget> componentsList;
  bool initiallyExpanded;

  CustomDropdownRow({
    Key? key,
    required this.title,
    required this.componentsList,
    this.initiallyExpanded = false,
  }) : super(key: key);

  @override
  State<CustomDropdownRow> createState() => _CustomDropdownRowState();
}

class _CustomDropdownRowState extends State<CustomDropdownRow> {
  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;
    final double maxHeight = MediaQuery.of(context).size.height;

    String title = widget.title;
    List<Widget> componentsList = widget.componentsList;
    bool initiallyExpanded = widget.initiallyExpanded;

    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontFamily: "SF Pro Display",
          fontWeight: FontWeight.w600,
        ),
      ),
      initiallyExpanded: initiallyExpanded,
      tilePadding: EdgeInsets.symmetric(horizontal: maxWidth * 0.048),
      textColor: const Color(0xFF04CEBC),
      collapsedTextColor: Colors.black,
      iconColor: const Color(0xFF04CEBC),
      collapsedIconColor: const Color(0xFFC8C7CC),
      children: componentsList,
    );
  }
}
