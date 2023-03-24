import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TitleViewAll extends StatefulWidget {
  final String title;
  // final Function onTap;
  const TitleViewAll({Key? key, required this.title}) : super(key: key);

  @override
  State<TitleViewAll> createState() => _TitleViewAllState();
}

class _TitleViewAllState extends State<TitleViewAll> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TextButton(
            onPressed: () => print('View all'),
            child: const Text(
              'View all',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
