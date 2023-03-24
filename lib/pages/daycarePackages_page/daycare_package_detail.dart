import 'package:dogs_park/models/daycare_package.dart';
import 'package:dogs_park/pages/daycarePackages_page/components/dog_option.dart';
import 'package:dogs_park/pages/daycarePackages_page/daycare_package_confirm.dart';
import 'package:dogs_park/pages/daycarePackages_page/daycare_package_pickup_return.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/dogs.dart';
import '../../utils/data_bucket.dart';
import 'daycare_package_confirm_not_pickup.dart';

class DayCarePackageDetail extends StatefulWidget {
  const DayCarePackageDetail({Key? key}) : super(key: key);

  @override
  State<DayCarePackageDetail> createState() => _DayCarePackageDetailState();
}

class _DayCarePackageDetailState extends State<DayCarePackageDetail> {
  TextEditingController noteTxtController = TextEditingController();
  StayingPeriodController periodController = StayingPeriodController();
  SelectPetController petController = SelectPetController();
  RxBool isPickup = false.obs;
  var idService = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var _PackageList = PackageList();
    var passingArgurment = [];
    var packageList = _PackageList.packageList;
    List<Service> serviceSelectedList = [];
    final RxDouble total =
        periodController.setStartTotal(_PackageList, idService).obs;
    final RxDouble packagePrice =
        periodController.setStartTotal(_PackageList, idService).obs;
    final RxDouble additionalServicePrices = 0.0.obs;
    final RxDouble dogWeightPrice = 0.0.obs;
    var updateTotal = () => total.value = packagePrice.value +
        additionalServicePrices.value +
        dogWeightPrice.value;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
          color: AppColors.black,
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: IconButton(
                color: AppColors.black,
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
                iconSize: 30,
              ))
        ],
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.maxWidth_005),
        child: ListView(children: [
          Padding(
            padding: EdgeInsets.only(
                top: Dimens.maxHeight_0005, bottom: Dimens.maxHeight_003),
            child: Text(Dimens.daycarePackage,
                style: AppTextStyle.daycarePackagesText),
          ),
          for (int i = 0; i < packageList[idService].service.length; i++)
            Obx(
              () => Row(
                children: [
                  Checkbox(
                      shape: const CircleBorder(),
                      value: packageList[idService].service[i].isSelected.value,
                      activeColor: AppColors.purple,
                      onChanged: (value) {
                        if (packageList[idService].service[i].enable == true) {
                          packageList[idService].service[i].isSelected.value =
                              value ?? false;

                          if (value!) {
                            additionalServicePrices.value +=
                                packageList[idService].service[i].price;
                            serviceSelectedList
                                .add(packageList[idService].service[i]);
                          } else {
                            additionalServicePrices.value -=
                                packageList[idService].service[i].price;
                            serviceSelectedList
                                .remove(packageList[idService].service[i]);
                          }

                          //update total
                          updateTotal();
                          print(serviceSelectedList);
                        }
                      }),
                  Text(
                    packageList[idService].service[i].name,
                    style: packageList[idService].service[i].isSelected.value
                        ? AppTextStyle.option_selected
                        : AppTextStyle.option_unselected,
                  ),
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.only(right: Dimens.maxHeight_0005, top: 37),
            child: Text(
              Dimens.period,
              style: AppTextStyle.daycareHeader,
            ),
          ),
          Obx(
            () => DropdownButton<String>(
              isExpanded: true,
              hint: const Text(
                Dimens.period,
                style: AppTextStyle.daycareSelection,
              ),
              onChanged: (newValue) {
                periodController.setSelected(newValue!);
                if (periodController.getValue() ==
                        periodController.periodList[0] ||
                    periodController.getValue() ==
                        periodController.periodList[1]) {
                  packagePrice.value = packageList[idService].price * 0.5;
                }
                if (periodController.getValue() ==
                    periodController.periodList[2]) {
                  packagePrice.value = packageList[idService].price * 0.75;
                }
                if (periodController.getValue() ==
                    periodController.periodList[3]) {
                  packagePrice.value = packageList[idService].price;
                }
                //update total
                updateTotal();
              },
              value: periodController.dropdownValue.value == ""
                  ? null
                  : periodController.dropdownValue.value,
              elevation: 16,
              items: periodController.periodList.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: AppTextStyle.period_option,
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: Dimens.maxHeight_0005, top: 37),
            child: Text(
              "Select pet",
              style: AppTextStyle.daycareHeader,
            ),
          ),
          Obx(
            () => DropdownButton<String>(
              underline: const SizedBox(),
              isExpanded: true,
              hint: const Text(
                "Select pet",
                style: AppTextStyle.daycareSelection,
              ),
              onChanged: (newValue) {
                petController.setSelectedDog(newValue!);
                dogWeightPrice.value = SelectPetController.getDogFeePercent(
                        petController.getSelectedtDog()!) *
                    packageList[idService].price;
                //update total
                updateTotal();
              },
              value: petController.dropdownValue.value == ""
                  ? null
                  : petController.dropdownValue.value,
              items: petController.addDogList().map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: DogOption(idDog: int.parse(value)),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: Dimens.maxHeight_0005, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pick up",
                  style: AppTextStyle.daycareHeader,
                ),
                IconButton(
                    onPressed: () async {
                      var res =
                          await Get.to(const DaycarePackagePickupReturn());
                      if ((res as List).length == 0) {
                        isPickup.value = false;
                      } else {
                        isPickup.value = true;
                        passingArgurment = res;
                        print(passingArgurment);
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
          Obx(
            () => isPickup.value
                ? (Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Date"),
                          Text(DateFormat.yMMMEd().format(DateTime.tryParse(
                              passingArgurment[0]['datetime'].toString())!))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Time"),
                          Text(passingArgurment[0]['time'])
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Location"),
                          SizedBox(
                            width: Dimens.maxWidth_05,
                            child: Text(
                              passingArgurment[1],
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
                : const SizedBox(
                    height: 0,
                  ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimens.maxWidth_005),
            margin: EdgeInsets.only(top: Dimens.maxHeight_005),
            decoration: BoxDecoration(
              color: AppColors.lightgray,
              borderRadius:
                  const BorderRadius.all(Radius.circular(Dimens.border_8)),
              border: Border.all(color: AppColors.lightgray),
            ),
            child: TextField(
              style: AppTextStyle.daycareTextField1,
              controller: noteTxtController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note',
                hintStyle: AppTextStyle.daycareTextField1
                    .copyWith(color: AppColors.darkgray),
                fillColor: AppColors.lightgray,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColors.lightgray,
                borderRadius:
                    const BorderRadius.all(Radius.circular(Dimens.border_8)),
                border: Border.all(color: AppColors.lightgray, width: 0.5)),
            padding: EdgeInsets.symmetric(
                vertical: Dimens.maxHeight_003,
                horizontal: Dimens.maxWidth_005),
            margin: EdgeInsets.only(top: Dimens.maxWidth_005),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    Dimens.total,
                    style: AppTextStyle.daycareConfirmInfo1,
                  ),
                  Obx(() => Text("${total.toInt()}\$",
                      style: AppTextStyle.daycareConfirmInfo1))
                ]),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: Dimens.maxHeight_005),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: EdgeInsets.only(top: Dimens.maxHeight_005),
              decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimens.border_8))),
              child: TextButton(
                  onPressed: () {
                    if (petController.getSelectedtDog() == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text(Dimens.pleaseDog)));
                    } else {
                      if (isPickup.value == true) {
                        Get.to(
                            DaycarePackageConfirm(
                              packageName:
                                  "${packageList[idService].name} - ${periodController.getSelectedPeriod()}",
                              dogPrice: dogWeightPrice.value,
                              servicesPrice: additionalServicePrices.value,
                              packagePrice: packagePrice.value,
                              dog: petController.getSelectedtDog()!,
                              listService: serviceSelectedList,
                              pickupDate:
                                  passingArgurment[0]['datetime'].toString(),
                              pickupTime:
                                  passingArgurment[0]['time'].toString(),
                              pickupLocation: passingArgurment[1].toString(),
                            ),
                            arguments: passingArgurment);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DaycarePackageConfirmNotPickUp(
                                        packageName:
                                            "${packageList[idService].name} - ${periodController.getSelectedPeriod()}",
                                        dogPrice: dogWeightPrice.value,
                                        servicesPrice:
                                            additionalServicePrices.value,
                                        packagePrice: packagePrice.value,
                                        dog: petController.getSelectedtDog()!,
                                        listService: serviceSelectedList)));
                      }
                    }
                  },
                  child: Text(
                    Dimens.next,
                    style: AppTextStyle.daycareConfirmInfo1
                        .copyWith(color: Colors.white),
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}

class StayingPeriodController extends GetxController {
  RxString dropdownValue = "".obs;
  List<String> periodList = [
    'Halfday (6AM-12PM)',
    'Halfday (12PM-6PM)',
    'Overnight (After 7PM)',
    'Fullday'
  ];

  String getValue() {
    String selectedValue = dropdownValue.value;
    return selectedValue;
  }

  String getSelectedPeriod() {
    String val = dropdownValue.value;
    //split string after '('
    if (val.contains('(')) {
      val = val.substring(0, val.indexOf('(') - 1);
    }
    return val;
  }

  void setSelected(String value) {
    dropdownValue.value = value;
  }

  double setStartTotal(PackageList packageList, int idService) {
    double total = packageList.packageList[idService].price;
    return total;
  }
}

class SelectPetController extends GetxController {
  final _dogList = DataBucket.getInstance().getDogList();
  RxString dropdownValue = "".obs;
  List<String> addDogList() {
    List<String> dogList = [];
    for (int i = 0; i < _dogList.length; i++) {
      dogList.add(_dogList[i].code);
    }
    return dogList;
  }

  void setSelectedDog(String value) {
    dropdownValue.value = value;
  }

  Dog? getSelectedtDog() {
    for (Dog dog in _dogList) {
      if (dog.code == dropdownValue.value) {
        return dog;
      }
    }
    return null;
  }

  // Dog Weight Price:
  // <9 kg - 0%
  // 9 - 16 kg - 20%
  // >16kg - 35%

  static double getDogFeePercent(Dog dog) {
//return % fee
    double? weight = double.tryParse(dog.weight);
    if (weight! > 16) {
      return 35 / 100;
    } else if (weight > 9) {
      return 20 / 100;
    }
    return 0;
  }
}
