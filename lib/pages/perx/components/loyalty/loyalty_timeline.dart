import 'package:dogs_park/models/perx/loyalty.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class LoyaltyTimeline extends StatelessWidget {
  final List<Tier> tiers;
  final int currentTierIndex;
  const LoyaltyTimeline({Key? key, required this.tiers, required this.currentTierIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Timeline.tileBuilder(
        shrinkWrap: true,
        theme: TimelineThemeData(
          color: Colors.white,
          direction: Axis.horizontal,
        ),
        builder: TimelineTileBuilder.connected(
          contentsAlign: ContentsAlign.basic,
          itemCount: tiers.length,
          contentsBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: tiers[index].images!.isNotEmpty
                  ? Image.network(
                      tiers[index]
                          .images!
                          .firstWhere(
                            (element) => element.type == 'loyalty_tier',
                          )
                          .url!,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    )
                  : Text(
                      tiers[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: tiers[index].pointsDifference == 0 ? Colors.green : Colors.grey,
                      ),
                    ),
            );
          },
          oppositeContentsBuilder: (context, index) => const SizedBox(
            width: 0,
            height: 0,
          ),
          indicatorBuilder: (context, index) {
            return Container(
              constraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == currentTierIndex ? Colors.green : Colors.white,
                border: Border.all(
                  color: tiers[index].pointsDifference == 0 ? Colors.green : Colors.grey,
                  width: 4,
                ),
              ),
              child: Center(
                child: tiers[index].pointsDifference == 0
                    ? Text(
                        String.fromCharCode(Icons.check_rounded.codePoint),
                        style: TextStyle(
                          color: index == currentTierIndex
                              ? Colors.white
                              : tiers[index].pointsDifference == 0
                                  ? Colors.green
                                  : Colors.blueGrey,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          fontFamily: Icons.check_rounded.fontFamily,
                          package: Icons.check_rounded.fontPackage,
                        ),
                      )
                    : Text(
                        tiers[index].pointsDifference.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
              ),
            );
          },
          connectorBuilder: (context, index, type) {
            return Container(
              width: (MediaQuery.of(context).size.width - 16 * 2) / 10,
              height: 4,
              decoration: BoxDecoration(
                color: tiers[index + 1].pointsDifference == 0 ? Colors.green : Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }
}
