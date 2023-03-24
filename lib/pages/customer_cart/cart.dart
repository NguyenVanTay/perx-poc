import 'package:dogs_park/models/daycare_package.dart';
import 'package:dogs_park/models/dogs.dart';
import 'package:dogs_park/pages/customer_cart/Components/activity_row.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Cart extends StatelessWidget {
  String packageName;
  double packagePrice;
  double servicesPrice;
  double dogPrice;
  Dog dog;
  String pickupDate;
  String pickupTime;
  String pickupLocation;
  List<Service> listService;
  bool isPickup;
  Cart(
      {super.key,
      required this.packageName,
      required this.dog,
      required this.packagePrice,
      required this.dogPrice,
      required this.servicesPrice,
      required this.listService,
      this.pickupDate = "",
      this.pickupTime = "",
      this.pickupLocation = "",
      this.isPickup = false});

  static String getReturnDate(String pickupdate) {
    DateTime? d = DateTime.tryParse(pickupdate);
    d = d!.add(Duration(days: 1));

    return DateFormat.yMd().format(d);
  }

  @override
  Widget build(BuildContext context) {
    String pickupD = "";
    String returnD = "";
    if (isPickup) {
      pickupD = DateFormat.yMd().format(DateTime.tryParse(pickupDate)!);
      returnD = getReturnDate(pickupDate);
    }
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: EdgeInsets.only(left: Dimens.maxWidth_003),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: Dimens.maxHeight_003),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {
                Get.back();
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Customer's Cart",
                style: AppTextStyle.daycarePackagesText,
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.black),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: Dimens.maxHeight_001,
          ),
          Row(
            children: [
              Container(
                width: Dimens.maxWidth_04,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.radius_14),
                    color: Colors.white38,
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/Loc.png'))),
              ),
              Container(
                // height: Dimens.maxHeight_026,
                width: Dimens.maxWidth_054,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimens.radius_14),
                      bottomRight: Radius.circular(Dimens.radius_14)),
                  color: AppColors.primary,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: Dimens.maxHeight_003),
                          child: const Text(
                            "Sola",
                            style: AppTextStyle.dogNameInCartText,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Dimens.maxHeight_002),
                          child: Text(packageName,
                              style: AppTextStyle.packageInCartText),
                        ),
                        isPickup
                            ? Padding(
                                padding:
                                    EdgeInsets.only(top: Dimens.maxHeight_001),
                                child: Text(
                                    "Check In: $pickupTime at  $pickupD",
                                    style: AppTextStyle.checkTextInCartText),
                              )
                            : const SizedBox(
                                height: 0,
                              ),
                        isPickup
                            ? Padding(
                                padding:
                                    EdgeInsets.only(top: Dimens.maxHeight_001),
                                child: Text("Check Out: $returnD",
                                    style: AppTextStyle.checkTextInCartText),
                              )
                            : const SizedBox(
                                height: 0,
                              ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Dimens.maxHeight_001,
                              bottom: Dimens.maxHeight_002),
                          child: Text("Pick up: ${isPickup ? "Yes" : "No"}",
                              style: AppTextStyle.checkTextInCartText),
                        ),
                      ]),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Dimens.maxHeight_001,
          ),
          const Text("Activity in Package",
              style: AppTextStyle.activityInCartText),
          SizedBox(
            height: Dimens.maxHeight_001,
          ),
          ...PackageList.getListServiceByPackageName(packageName)!.map(
            (e) => ActivityRow(
                activityDescription: e.name,
                activityName: e.name,
                activityPrice: e.price.toDouble()),
          ),
          ...listService.map(
            (e) => ActivityRow(
                activityDescription: e.name,
                activityName: e.name,
                activityPrice: e.price.toDouble()),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.lightgray,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(Dimens.border_8)),
                  border: Border.all(color: AppColors.lightgray, width: 0.5)),
              padding: EdgeInsets.symmetric(
                  vertical: Dimens.maxHeight_003,
                  horizontal: Dimens.maxWidth_005),
              margin: EdgeInsets.only(top: Dimens.maxWidth_005),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      Dimens.total,
                      style: AppTextStyle.daycareConfirmInfo1,
                    ),
                    Text("\$${dogPrice + packagePrice + servicesPrice}",
                        style: AppTextStyle.daycareConfirmInfo1)
                  ]),
            ),
          ),
          SizedBox(
            height: Dimens.maxHeight_002,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: Dimens.maxHeight_005, right: 10),
            child: SizedBox(
              height: Dimens.maxHeight_007,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.radius_8),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Dimens.checkOut,
                        style: AppTextStyle.daycareConfirmInfo1.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
                onPressed: () => {},
              ),
            ),
          ),
        ],
      ),
    )));
  }
}
