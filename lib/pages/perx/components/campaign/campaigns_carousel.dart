import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:dogs_park/models/perx/campaign.dart';
import 'package:dogs_park/pages/perx/components/campaign/campaign_item.dart';
import 'package:dogs_park/pages/perx/components/title_viewall.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CampaignsCarousel extends StatefulWidget {
  final String userToken;
  const CampaignsCarousel({super.key, required this.userToken});

  @override
  State<CampaignsCarousel> createState() => _CampaignsCarouselState();
}

class _CampaignsCarouselState extends State<CampaignsCarousel> {
  int currentIndexCarousel = 0;
  bool isLoading = true;
  final CarouselController _carouselController = CarouselController();
  final List<Campaign> campaigns = [];

  Future<void> getCampaigns() async {
    // Init Dio
    Dio dio = Dio();
    String url = "${dotenv.get("PERX_HOST")}/v4/campaigns";
    String method = "GET";
    late Map<String, String> header = {"Authorization": "Bearer ${widget.userToken}"};
    Map params = {"page": "3"};

    try {
      // Call API
      Response response = await dio.request(
        url,
        data: params,
        options: Options(method: method, headers: header),
      );

      // Assign campaigns
      for (var item in response.data['data']) {
        campaigns.add(
          Campaign.fromJson(item),
        );
      }

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
    getCampaigns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleViewAll(title: "Campaigns"),
        isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              )
            : Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 16 * 12,
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      onPageChanged: (index, reason) => setState(() => currentIndexCarousel = index),
                      enlargeCenterPage: true,
                    ),
                    carouselController: _carouselController,
                    items: List.generate(campaigns.length, (index) => index + 1)
                        .map(
                          (e) => Builder(
                            builder: (context) => CampaignItem(
                              campaign: campaigns[e - 1],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(campaigns.length, (index) => index + 1)
                          .asMap()
                          .entries
                          .map(
                            (entry) => GestureDetector(
                              onTap: () => _carouselController.animateToPage(entry.key),
                              child: Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(
                                    currentIndexCarousel == entry.key ? 0.6 : 0.2,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
