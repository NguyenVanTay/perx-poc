import 'package:amity_sdk/amity_sdk.dart';
import 'package:get/get.dart';
import '../../social_pages/components/alert_dialog.dart';

class AmityLoginController extends GetxController {

  AmityUser? currentAmityUser;
  RxBool isProcessing = false.obs;




  Future<void> login(String userID, String name) async {
    if (!isProcessing.value) {
      isProcessing.value = true;

      print("login with $userID");

       await AmityCoreClient.login(userID).displayName(name).submit().then((value) async {
        print("success");

        isProcessing.value = false;
        getUserByID(userID);
        currentAmityUser = value;
        // notifyListeners();
      }).catchError((error, stackTrace) async {
        isProcessing.value = false;
        print(error.toString());
        await AmityDialog()
            .showAlertErrorDialog(title: "Error!", message: error.toString());
      });

    } else {
      /// processing
      print("processing login...");
    }
  }

  void setProcessing(bool isProcessing) {
    this.isProcessing.value = isProcessing;
    // notifyListeners();
  }

  Future<void> refreshCurrentUserData() async {
    if (currentAmityUser != null) {
      await AmityCoreClient.newUserRepository()
          .getUser(currentAmityUser!.userId!)
          .then((user) {
        currentAmityUser = user;
        //TODO: update
      }).onError((error, stackTrace) async {
        print(error.toString());
        await AmityDialog()
            .showAlertErrorDialog(title: "Error!", message: error.toString());
      });
    }
  }

  Future<void> getUserByID(String id) async {
    await AmityCoreClient.newUserRepository().getUser(id).then((user) {
      print("IsGlobalban: ${user.isGlobalBan}");
    }).onError((error, stackTrace) async {
      print(error.toString());
    });
  }
}
