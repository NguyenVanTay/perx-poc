import 'package:get/get.dart';
import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
class MainPageController extends GetxController{
  RxInt selectedIndex =0.obs;

  onItemTaped(int index){
    selectedIndex.value = index;
  }
}