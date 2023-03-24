import 'package:dio/dio.dart';
import 'package:dogs_park/models/perx/loyalty_transaction.dart';
import 'package:dogs_park/pages/perx/components/loyalty/loyalty_description.dart';
import 'package:dogs_park/pages/perx/components/loyalty/loyalty_tier_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';
import 'package:dogs_park/models/perx/loyalty.dart';

class LoyaltyProgramDetail extends StatefulWidget {
  final Loyalty loyalty;
  final List<Tier> tiers;
  final Tier currentTier;
  final int currentTierIndex;
  final String userToken;

  const LoyaltyProgramDetail(
      {Key? key,
      required this.loyalty,
      required this.tiers,
      required this.currentTier,
      required this.currentTierIndex,
      required this.userToken})
      : super(key: key);

  @override
  State<LoyaltyProgramDetail> createState() => _LoyaltyProgramDetailState();
}

class _LoyaltyProgramDetailState extends State<LoyaltyProgramDetail> {
  List<LoyaltyTransaction> transactions = [];
  bool isLoading = true;

  Future<void> getLoyaltyTransactions() async {
    Dio dio = Dio();
    String url = "${dotenv.env['PERX_HOST']}/v4/loyalty/transactions_history";

    String method = "GET";
    Map<String, String> headers = {
      "Authorization": "Bearer ${widget.userToken}",
    };
    Map<String, String> params = {};

    try {
      Response response = await dio.request(url, data: params, options: Options(method: method, headers: headers));

      // filter data with loyalty id = 1
      transactions = (response.data['data'] as List)
          .map((e) => LoyaltyTransaction.fromJson(e))
          .where((element) => element.loyaltyId == 1)
          .toList();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    getLoyaltyTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.adaptive.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.loyalty.name),
      ),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // Image
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      height: 16 * 12,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      widget.loyalty.images!.firstWhere((element) => element.type == 'loyalty_banner').url!,
                    ),
                  ),
                  Container(
                    height: 16 * 12,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(
                      left: 8,
                      bottom: 8,
                      right: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                        ],
                        stops: const [0.6, 1],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              widget.loyalty.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Image.network(
                                        height: 16,
                                        width: 16,
                                        fit: BoxFit.cover,
                                        widget
                                            .currentTier
                                            .images!
                                            .firstWhere((element) => element.type == 'loyalty_tier')
                                            .url!,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.currentTier.name,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              //reviewEnd in format "01 August 2022 (1 day left)"
                              "End on ${DateFormat('dd MMMM yyyy').format(widget.loyalty.review!.reviewEnd!)} (${widget.loyalty.review!.reviewEnd!.difference(DateTime.now()).inDays} ${widget.loyalty.review!.reviewEnd!.difference(DateTime.now()).inDays > 1 ? "days" : "day"} left)",
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${widget.loyalty.currentPoints.toString()} points",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                if (widget.loyalty.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: LoyaltyDescription(loyalty: widget.loyalty),
                  ),
                // Tiers timeline
                Timeline.tileBuilder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  theme: TimelineThemeData(
                    color: Colors.white,
                    direction: Axis.vertical,
                    nodePosition: 0.3,
                  ),
                  builder: TimelineTileBuilder.connected(
                    itemCount: widget.tiers.length,
                    contentsAlign: ContentsAlign.reverse,
                    indicatorBuilder: (context, index) => Container(
                      constraints: const BoxConstraints(
                        minWidth: 64,
                        minHeight: 64,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == widget.currentTierIndex ? Colors.green : Colors.white,
                        border: Border.all(
                          width: 4,
                          color: index <= widget.currentTierIndex ? Colors.green : Colors.blueGrey,
                        ),
                      ),
                      child: Center(
                        child: widget.tiers[index].pointsDifference == 0
                            ? Text(
                                String.fromCharCode(Icons.check_rounded.codePoint),
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: Icons.check_rounded.fontFamily,
                                  package: Icons.check_rounded.fontPackage,
                                  color: index == widget.currentTierIndex ? Colors.white : Colors.green,
                                ),
                              )
                            : Text(
                                widget.tiers[index].pointsDifference.toString(),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.blueGrey,
                                ),
                              ),
                      ),
                    ),
                    connectorBuilder: (context, index, type) => SizedBox(
                      height: 32,
                      child: SolidLineConnector(
                        color: index < widget.currentTierIndex ? Colors.green : Colors.blueGrey,
                        thickness: 4,
                      ),
                    ),
                    contentsBuilder: (context, index) => LoyaltyTierDetail(
                      currentIndex: index,
                      currentTierIndex: widget.currentTierIndex,
                      tier: widget.tiers[index],
                    ),
                    oppositeContentsBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        widget.tiers[index].pointsDifference! == 0
                            ? "You have archived this tier"
                            : "You need ${widget.tiers[index].pointsDifference!} more points to archive this tier",
                        style: TextStyle(
                          color: widget.tiers[index].pointsDifference == 0 ? Colors.green : Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: transactions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: const Icon(Icons.account_balance_wallet_rounded),
                        title: Text(transactions[index].name.toString()),
                        trailing: Text(
                          transactions[index].amount.toString(),
                          style: TextStyle(
                            color:
                                transactions[index].transactionType == TransactionType.earn ? Colors.green : Colors.red,
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
