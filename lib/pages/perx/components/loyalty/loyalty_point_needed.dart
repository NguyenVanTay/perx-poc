import 'package:dogs_park/models/perx/loyalty.dart';
import 'package:flutter/widgets.dart';

class LoyaltyPointNeeded extends StatelessWidget {
  const LoyaltyPointNeeded({
    Key? key,
    required this.tiers,
    required this.currentTierIndex,
  }) : super(key: key);

  final List<Tier> tiers;
  final int currentTierIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        'You need ${tiers[currentTierIndex + 1].pointsDifference} more points to reach the ${tiers[currentTierIndex + 1].name} tier',
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
