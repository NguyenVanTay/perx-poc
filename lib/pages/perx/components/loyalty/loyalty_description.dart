import 'package:dogs_park/models/perx/loyalty.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoyaltyDescription extends StatefulWidget {
  final Loyalty loyalty;

  const LoyaltyDescription({Key? key, required this.loyalty}) : super(key: key);

  @override
  State<LoyaltyDescription> createState() => _LoyaltyDescriptionState();
}

class _LoyaltyDescriptionState extends State<LoyaltyDescription> {
  bool isExpanded = false;
  int maxLines = 3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (kDebugMode) {
          print("Khoicute");
        }
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.loyalty.description!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: isExpanded ? 512 : maxLines,
            textAlign: TextAlign.justify,
          ),
          Text(
            isExpanded ? 'show less' : 'show more',
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
