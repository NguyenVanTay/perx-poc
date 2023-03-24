import 'package:flutter/material.dart';

class SelectUser extends StatelessWidget {
  final String userID;
  final bool isSelected;
  const SelectUser({required this.userID, this.isSelected = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8.0),
                decoration: const BoxDecoration(
                    color: Colors.grey, shape: BoxShape.circle),
                width: 35,
                height: 35,
              ),
              Text(userID)
            ],
          ),
          isSelected
              ? const Icon(
                  Icons.check,
                  color: Colors.green,
                )
              : const SizedBox(
                  width: 5,
                  height: 5,
                )
        ],
      ),
    );
  }
}
