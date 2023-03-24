import 'dart:convert';

import 'package:dogs_park/models/customers.dart';
import 'package:dogs_park/models/daycare_package.dart';
import 'package:dogs_park/pages/customer_cart/cart.dart';
import 'package:dogs_park/pages/daycarePackages_page/daycare_package_detail.dart';
import 'package:dogs_park/theme/dimens.dart';

import 'package:dogs_park/utils/data_bucket.dart';
import 'package:dogs_park/utils/networking.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/dogs.dart';
import '../../theme/colors.dart';
import '../../widgets/text_style.dart';
import '../widget/app_switch.dart';

// ignore: must_be_immutable
class DaycarePackageConfirm extends StatelessWidget {
  String packageName;
  double packagePrice;
  double servicesPrice;
  double dogPrice;
  Dog dog;
  String pickupDate;
  String pickupTime;
  String pickupLocation;
  List<Service> listService;
  DaycarePackageConfirm(
      {Key? key,
      required this.packageName,
      required this.dog,
      required this.packagePrice,
      required this.dogPrice,
      required this.servicesPrice,
      required this.listService,
      required this.pickupDate,
      required this.pickupTime,
      required this.pickupLocation})
      : super(key: key);
  final Customer customer = DataBucket.getInstance().getCustomerList();
  final TextEditingController dogInfomationController = TextEditingController();

  // List confirmList = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var packageList = PackageList().packageList;
    print("Daycare Confirm");
    // print(confirmList);

    print(getDogInformation(dog));
    DateTime? dateTime = DateTime.tryParse(pickupDate);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
          color: AppColors.black,
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 16),
            child:
                Text('Confirmation', style: AppTextStyle.daycarePackagesText),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 33.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date & Time',
                      style: AppTextStyle.daycareHeader2,
                    ),
                    //TODO: replace with data
                    Text(
                      DateFormat.yMMMEd().format(dateTime!),
                      style: AppTextStyle.daycareConfirmInfo1,
                    ),
                    //TODO: replace with data
                    Text(pickupTime, style: AppTextStyle.daycareConfirmInfo2),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 33.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Location',
                      style: AppTextStyle.daycareHeader2,
                    ),
                    SizedBox(
                      width: Dimens.screenWidth * 0.9,
                      height: Dimens.maxHeight_008,
                      child: Text(
                        pickupLocation,
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        style: AppTextStyle.daycareConfirmInfo1,
                      ),
                    ),

                    // const Text('0.31 km away',
                    //     style: AppTextStyle.daycareConfirmInfo2),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Package',
                  style: AppTextStyle.daycareHeader2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      packageName,
                      style: AppTextStyle.daycareConfirmInfo1,
                    ),
                    Text(
                      "$packagePrice\$",
                      style: AppTextStyle.daycareConfirmInfo2,
                    )
                  ],
                ),
                ...listService.map((e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.name,
                          style: AppTextStyle.daycareConfirmInfo2,
                        ),
                        Text(
                          "${e.price.toInt()}\$",
                          style: AppTextStyle.daycareConfirmInfo2,
                        )
                      ],
                    )),
                SelectPetController.getDogFeePercent(dog) == 0
                    ? SizedBox(
                        height: 0,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Additional fee: ",
                            style: AppTextStyle.daycareConfirmInfo2,
                          ),
                          Text(
                            "$dogPrice\$",
                            style: AppTextStyle.daycareConfirmInfo2,
                          )
                        ],
                      ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            decoration: BoxDecoration(
              color: Color(0xFFf9f9f9),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: Color(0xFFEFEFF4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Customer\'s information',
                    style: AppTextStyle.daycareTextField1
                        .copyWith(color: AppColors.darkgray),
                  ),
                ),
                Text(
                  getOwnerInformation(customer),
                  style: AppTextStyle.daycareTextField1
                      .copyWith(color: AppColors.black, height: 1.4),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFf9f9f9),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: Color(0xFFEFEFF4)),
            ),
            constraints: BoxConstraints(minHeight: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Dog\'s information',
                    style: AppTextStyle.daycareTextField1
                        .copyWith(color: AppColors.darkgray),
                  ),
                ),
                Text(
                  getDogInformation(dog),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Color(0xFFEFEFF4), width: 0.5)),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total'),
                  Text("${packagePrice + servicesPrice + dogPrice}\$")
                ]),
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.only(bottom: 26),
            decoration: const BoxDecoration(
                color: Color(0xFF04CEBC),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: TextButton(
              onPressed: () async {
                await _handleDaycareConfirm();
                Get.to(Cart(
                  packageName: packageName,
                  dog: dog,
                  listService: listService,
                  dogPrice: dogPrice,
                  servicesPrice: servicesPrice,
                  packagePrice: packagePrice,
                  pickupDate: pickupDate,
                  pickupLocation: pickupLocation,
                  pickupTime: pickupTime,
                  isPickup: true,
                ));
              },
              child: Text(
                'Confirm',
                style: AppTextStyle.daycareConfirmInfo1
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  String getDogInformation(Dog dog) =>
      "Name: ${dog.dogName}\nAge: ${dog.age}\nWeight: ${dog.weight}\nGender: ${dog.gender}\nBreed: ${dog.breed}";

  String getOwnerInformation(Customer customer) =>
      "Name: ${customer.fullname}\nAge: ${DateTime.now().year - customer.dateofbirth.year}\nPhone: ${customer.phonenumber}\nAddress: ${customer.address}";
  Future<void> _handleDaycareConfirm() async {
    Map data = {
      "CustomerPhoneNumber": customer.phonenumber,
      "DogCode": dog.code,
      "DogSize": "Small",
      "StaffPhoneNumber": "000000001",
      "Package": packageName,
      "PackageTime": "1",
    };
    String dataJson = jsonEncode(data);
    var createDaycare = await Networking.getInstance()
        .postDaycare('PetsPark/hs/DogsPark/V1/DayCare', dataJson);
    //TODO: check valid data
  }
}
