import 'package:dio/dio.dart';
import 'package:dogs_park/models/perx/loyalty.dart';
import 'package:dogs_park/pages/perx/components/loyalty/loyalty_program_detail.dart';
import 'package:dogs_park/pages/perx/components/loyalty/loyalty_info.dart';
import 'package:dogs_park/pages/perx/components/loyalty/loyalty_point_needed.dart';
import 'package:dogs_park/pages/perx/components/loyalty/loyalty_timeline.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoyaltySection extends StatefulWidget {
  final String userToken;
  const LoyaltySection({Key? key, required this.userToken}) : super(key: key);

  @override
  State<LoyaltySection> createState() => _LoyaltySectionState();
}

class _LoyaltySectionState extends State<LoyaltySection> {
  bool isLoading = true;
  late Loyalty loyalty = Loyalty();
  late List<Tier> tiers = [];
  late Tier currentTier = Tier();
  late int currentTierIndex;

  Future<void> getLoyaltyList() async {
    // Init Dio
    Dio dio = Dio();
    String url = "${dotenv.get("PERX_HOST")}/v4/loyalty/${1}";
    String method = "GET";
    Map<String, String> params = {};
    Map<String, String> header = {"Authorization": "Bearer ${widget.userToken}"};

    try {
      // Call API
      Response response = await dio.request(url, data: params, options: Options(method: method, headers: header));

      // Assign data
      loyalty = Loyalty.fromJson(response.data['data']);
      tiers = loyalty.tiers!;
      currentTierIndex = loyalty.tiers!.indexWhere((tier) => tier.pointsDifference != 0) - 1;
      currentTier = loyalty.tiers![currentTierIndex];

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
    getLoyaltyList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                // Jump to LoyaltyProgramDetail
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoyaltyProgramDetail(
                      loyalty: loyalty,
                      tiers: tiers,
                      currentTier: currentTier,
                      currentTierIndex: currentTierIndex,
                      userToken: widget.userToken,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(4, 4)),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoyaltyInfo(loyalty: loyalty, currentTier: currentTier),
                    Center(
                      child: Column(
                        children: [
                          LoyaltyTimeline(
                            tiers: tiers,
                            currentTierIndex: currentTierIndex,
                          ),
                          LoyaltyPointNeeded(
                            tiers: tiers,
                            currentTierIndex: currentTierIndex,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
