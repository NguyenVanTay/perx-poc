import 'package:flutter/material.dart';

class GenderIcon extends StatefulWidget {
  String gender;

  GenderIcon({
    Key? key,
    required this.gender,
  }) : super(key: key);
  @override
  State<GenderIcon> createState() => _RenderGenderIconState();
}

class _RenderGenderIconState extends State<GenderIcon> {
  @override
  Widget build(BuildContext context) {
    String gender = widget.gender;

    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
                width: 0.5, color: const Color.fromARGB(26, 0, 0, 0))),
        child: Padding(
          padding: const EdgeInsets.all(1.9),
          child: gender == 'Male'
              ? const Icon(
                  Icons.male_rounded,
                  color: Colors.blue,
                  size: 18,
                )
              : const Icon(
                  Icons.female_rounded,
                  color: Colors.pink,
                  size: 18,
                ),
        ));
  }
}
