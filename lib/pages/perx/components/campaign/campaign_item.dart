import 'package:dogs_park/models/perx/campaign.dart';
import 'package:dogs_park/models/perx/image.dart';
import 'package:flutter/material.dart';

class CampaignItem extends StatefulWidget {
  final Campaign campaign;
  const CampaignItem({super.key, required this.campaign});

  @override
  State<CampaignItem> createState() => _CampaignItemState();
}

class _CampaignItemState extends State<CampaignItem> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        // find image have type = 'banner campaign'
        widget.campaign.images!.isNotEmpty
            ? widget.campaign.images!
                .firstWhere(
                  (element) => element.type == 'campaign_banner',
                  orElse: () => PerxImage(
                    url:
                        "https://via.placeholder.com/1280x720.png?text=Campaign+banner+not+found",
                  ),
                )
                .url!
            : "https://via.placeholder.com/1280x720.png?text=Campaign+banner+not+found",
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
