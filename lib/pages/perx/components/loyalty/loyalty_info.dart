import 'package:dogs_park/models/perx/loyalty.dart';
import 'package:flutter/material.dart';

class LoyaltyInfo extends StatelessWidget {
  const LoyaltyInfo({
    Key? key,
    required this.loyalty,
    required this.currentTier,
  }) : super(key: key);

  final Loyalty loyalty;
  final Tier currentTier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loyalty.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              "${loyalty.review!.reviewEnd!.difference(DateTime.now()).inDays} "
              "days left",
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: "Current tier: ",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                children: [
                  currentTier.images!.isNotEmpty
                      ? WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Image.network(
                              currentTier.images!.firstWhere((element) => element.type == 'loyalty_tier').url!,
                              height: 16,
                            ),
                          ),
                        )
                      : const WidgetSpan(
                          child: SizedBox(
                            width: 0,
                            height: 0,
                          ),
                        ),
                  TextSpan(
                    text: currentTier.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Your points: ${loyalty.currentPoints} points",
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        )
      ],
    );
  }
}
