import 'package:dogs_park/models/perx/image.dart';
import 'package:dogs_park/models/perx/reward.dart';
import 'package:flutter/material.dart';

class RewardItem extends StatefulWidget {
  final Reward reward;
  const RewardItem({super.key, required this.reward});

  @override
  State<RewardItem> createState() => _RewardItemState();
}

class _RewardItemState extends State<RewardItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(2, 2), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            widget.reward.images!.isNotEmpty
                ? widget
                    .reward
                    .images!
                    .firstWhere(
                      (element) => element.type == 'reward_thumbnail',
                      orElse: () => PerxImage(
                        url:
                            "https://via.placeholder.com/128.png?text=Reward+thumbnail+not+found",
                      ),
                    )
                    .url!
                : "https://via.placeholder.com/128x128.png?text=Reward+thumbnail+not+found",
            fit: BoxFit.cover,
            height: 16 * 5,
            width: 16 * 5,
          ),
        ),
        title: Text(
          widget.reward.name!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.reward.subtitle != null
              ? widget.reward.subtitle!
              : "No subtitle",
        ),
        trailing:
            // button with border radius, shadow
            TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
            shadowColor: Colors.lightBlue.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {},
          child: const Text(
            "Redeem",
          ),
        ),
      ),
    );
  }
}
