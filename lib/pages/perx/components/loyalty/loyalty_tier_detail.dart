import 'package:dogs_park/models/perx/loyalty.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoyaltyTierDetail extends StatelessWidget {
  final int currentIndex;
  final int currentTierIndex;
  final Tier tier;

  const LoyaltyTierDetail({
    Key? key,
    required this.currentIndex,
    required this.currentTierIndex,
    required this.tier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) print(MediaQuery.of(context).size.width);

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                tier.images!.isNotEmpty
                    ? WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Image.network(
                            tier.images!.firstWhere((element) => element.type == 'loyalty_tier').url!,
                            height: 20,
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
                  text: tier.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
