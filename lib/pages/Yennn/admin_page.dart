import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/admin_controller.dart';
import '../../widgets/customTextField.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final adminController = Get.put(AdminController());
  TextEditingController txtAmity = TextEditingController();
  TextEditingController pointPerx = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body:Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                fieldName: "Article conditions",
                controllerName: txtAmity,
                enabled: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0,bottom: 24,left: 64,right: 64),
                child: GestureDetector(
                  onTap: () {
                    adminController.amityPostCondition.value = txtAmity.text;
                    Get.snackbar("Notification", "set Article conditions success");
                  },
                  child: Container(
                    height: 32,

                    // padding: const EdgeInsets.all(Dimens.padding_20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green,
                    ),
                    child: const Center(
                      child: Text(
                        "Set Article Condition",
                        style:TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              CustomTextField(
                textInputType: TextInputType.number,
                fieldName: "Enter point of loyalty",
                controllerName: pointPerx,
                enabled: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0,bottom: 24,left: 64,right: 64),
                child: GestureDetector(
                  onTap: (){
                    adminController.pointPerx.value = int.parse(pointPerx.text);
                    Get.snackbar("Notification", "set Perx point success");
                  },
                  child: Container(
                    height: 32,
                    // padding: const EdgeInsets.all(Dimens.padding_20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.orange,
                    ),
                    child: const Center(
                      child: Text(
                        "Set Loyalty Point",
                        style:TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
