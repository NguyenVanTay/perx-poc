import 'package:dio/dio.dart';
import 'package:dogs_park/models/perx/reward.dart';
import 'package:dogs_park/pages/perx/components/reward/reward_item.dart';
import 'package:dogs_park/pages/perx/components/title_viewall.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RewardList extends StatefulWidget {
  final String userToken;
  const RewardList({super.key, required this.userToken});
  @override
  State<RewardList> createState() => _RewardListState();
}

class _RewardListState extends State<RewardList> {
  bool isLoading = true;
  List<Reward> rewards = [];

  Future<void> getRewards() async {
    // Init Dio
    Dio dio = Dio();
    String url = "${dotenv.get("PERX_HOST")}/v4/rewards";
    String method = "GET";
    Map<String, String> header = {
      "Authorization": "Bearer ${widget.userToken}"
    };
    Map<String, dynamic> params = {};

    // Call API
    try {
      Response response = await dio.request(url,
          data: params, options: Options(method: method, headers: header));

      // Assign rewards
      response.data['data'].forEach((item) {
        rewards.add(Reward.fromJson(item));
      });

      // // Filter rewards that have selling_to
      // rewards.removeWhere((element) => element.sellingTo == null);

      // // Sort rewards by selling_to desc
      // rewards.sort((a, b) => b.sellingTo!.compareTo(a.sellingTo!));

      // Take first 5 rewards
      rewards = rewards.take(5).toList();

      // Set state
      isLoading = false;
      setState(() {});
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    getRewards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleViewAll(
          title: "Rewards",
        ),
        isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: rewards.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return RewardItem(reward: rewards[index]);
                },
              )
      ],
    );
  }
}
