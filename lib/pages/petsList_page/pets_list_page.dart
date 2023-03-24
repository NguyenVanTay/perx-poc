import 'package:dogs_park/pages/signupPet_page/signup_pet_page.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/pets_list_controller.dart';
import 'components/body.dart';

class PetLists extends GetView<PetsListController> {
  PetLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FittedBox(
          child: FloatingActionButton(
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add),
              onPressed: () {
                Get.to(SignUpPetPage());
              }),
        ),

        // appBar: AppBar(
        //   title: const Text(
        //     'Pets list',
        //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        //   ),
        //   centerTitle: true,
        //   flexibleSpace: const GradientAppBarColor(),
        //   actions: [
        //     IconButton(
        //       icon: const Icon(Icons.shopping_cart, color: Colors.black),
        //       highlightColor: Colors.transparent,
        //       splashColor: Colors.transparent,
        //       onPressed: () {},
        //     ),
        //     IconButton(
        //       icon: const Icon(Icons.notifications, color: Colors.black),
        //       highlightColor: Colors.transparent,
        //       splashColor: Colors.transparent,
        //       onPressed: () {
        //         setState(
        //           () {
        //             // enabled = !enabled;
        //             // if enabled = false again, send api to update database
        //           },
        //         );
        //       },
        //     ),
        //   ],
        // ),
        body: const SafeArea(child: PetListBody()));
  }
}
