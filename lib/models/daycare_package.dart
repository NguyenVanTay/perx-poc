import 'package:dogs_park/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageModel {
  final String name;
  final double price;
  final Icon icon;
  final int id;
  final List<Service> service;

  PackageModel({
    required this.name,
    required this.price,
    required this.icon,
    required this.id,
    required this.service,
  });
}

class PackageList {
  static final List<Service> serviceBasicList = [
    Service(name: "Meal", isSelected: true.obs, enable: false, price: 25),
    Service(name: "Swim", isSelected: true.obs, enable: false, price: 25),
    Service(name: "Basic play", isSelected: true.obs, enable: false, price: 25),
    Service(name: "Private dorm", isSelected: false.obs, price: 25),
    Service(
        name: "General dorm", isSelected: true.obs, enable: false, price: 25),
    Service(name: "2-way livefeed", isSelected: false.obs, price: 25),
    Service(name: "In room tv", isSelected: false.obs, price: 25),
    Service(name: "In room toys", isSelected: false.obs, price: 25),
  ];
  static final List<Service> serviceAdvanceList = [
    Service(name: "Meal", isSelected: true.obs, enable: false, price: 25),
    Service(name: "Swim", isSelected: true.obs, enable: false, price: 25),
    Service(name: "Basic play", isSelected: true.obs, enable: false, price: 25),
    Service(
        name: "Private dorm", isSelected: true.obs, enable: false, price: 25),
    Service(
        name: "General dorm", isSelected: true.obs, enable: false, price: 25),
    Service(name: "2-way livefeed", isSelected: false.obs, price: 25),
    Service(name: "In room tv", isSelected: false.obs, price: 25),
    Service(name: "In room toys", isSelected: false.obs, price: 25),
  ];
  static final List<Service> serviceProList = [
    Service(name: "Meal", isSelected: true.obs, enable: false, price: 25),
    Service(name: "Swim", isSelected: true.obs, enable: false, price: 25),
    Service(name: "Basic play", isSelected: true.obs, enable: false, price: 25),
    Service(
        name: "Private dorm", isSelected: true.obs, enable: false, price: 25),
    Service(
        name: "General dorm", isSelected: true.obs, enable: false, price: 25),
    Service(
        name: "2-way livefeed", isSelected: true.obs, enable: false, price: 25),
    Service(name: "In room tv", isSelected: true.obs, enable: false, price: 25),
    Service(
        name: "In room toys", isSelected: true.obs, enable: false, price: 25),
  ];

  static List<Service>? getListServiceByPackageName(String packageName) {
    if (packageName.toLowerCase().contains('pro')) return serviceProList;
    if (packageName.toLowerCase().contains('advan')) return serviceAdvanceList;
    return serviceBasicList;
  }

  late List<PackageModel> packageList;

  PackageList() {
    packageList = [
      PackageModel(
          id: 1,
          name: "BASIC",
          price: 100.0,
          icon: const Icon(Icons.youtube_searched_for_outlined,
              color: AppColors.white),
          service: serviceBasicList),
      PackageModel(
          id: 2,
          name: "ADVANCE",
          price: 120,
          icon: const Icon(
            Icons.tiktok_outlined,
            color: AppColors.white,
          ),
          service: serviceAdvanceList),
      PackageModel(
          id: 3,
          name: "PRO",
          price: 150.0,
          icon: const Icon(Icons.play_arrow_outlined, color: AppColors.white),
          service: serviceProList)
    ];
  }
}

class Service {
  final String name;
  RxBool isSelected;
  bool enable;
  int price;
  Service(
      {required this.name,
      required this.isSelected,
      this.enable = true,
      this.price = 0});
}

//: load list service from api
// var serviceList = [
//   {"name": "Meal", "price": 25, "priority": 1},
//   {"name": "Swim", "price": 25, "priority": 1},
//   {"name": "Basic play", "price": 25, "priority": 1},
//   {"name": "Private dorm", "price": 25, "priority": 1},
//   {"name": "General dorm", "price": 25, "priority": 2},
//   {"name": "2-way livefeed", "price": 25, "priority": 3},
//   {"name": "In room tv", "price": 25, "priority": 3},
//   {"name": "In room toys", "price": 25, "priority": 3},
// ];

