import 'package:flutter/material.dart';
import '../models/customers.dart';
import '../models/dogs.dart';
import 'utils.dart';

class DataBucket {
  static DataBucket _instance = DataBucket._internal();
  DataBucket._internal();

  static DataBucket getInstance() => _instance;

  void setMetaData(dynamic rawData, loggedUser) {
    //setCustomerList(rawData[0]['CustomerList']);
    //setDeviceList(rawData[1]['Devices']);

    //----------------------------cms-----------------------
    // setSupportList(rawData[0]['SupportList']);
    setCustomerList(rawData[0]['Customer']);
    setDogList(rawData[0]['OwnedDog']);

    //---------------------------cms2-----------------------
    // setSupportList(rawData[2]['SupportList']);
    // setUserData(rawData[3]['UserName']);
    // setProductList(rawData[4]['Product']);
  }

  List<Dog> _dogList = [];
  List<Dog> getDogList() => _dogList;
  void setDogList(List<dynamic> rawList) {
    _dogList = [];
    Image base64Image;
    for (var item in rawList) {
      var code = item['Code'].toString();
      var name = item['DogName'].toString();
      var owner = item['Owner'].toString();
      var breed = item['DogBreed'].toString();
      if (item['Picture'] == "") {
        base64Image = Image.asset("images/dog_default.jpg");
      } else {
        base64Image =
            base64ToImage(item['Picture'].toString().replaceAll('\r\n', ''));
      }

      var gender = item['Gender'].toString();
      var weight = item['Weight'].toString();
      var dateOfBirth = DateTime.parse(item['DateOfBirth'].toString());
      //var dateOfBirth = DateTime.parse(item['DateOfBirth'].toString());r
      var sterilized = item['Sterilized'].toString();
      var age = item['Age'].toString();
      var microchip = item['Microchip'].toString();
      var furColor = item['Furcolor'].toString();
      var species = item['Species'].toString();

      _dogList.add(Dog(code, name, owner, breed, gender, base64Image, weight,
          sterilized, age, microchip, furColor, dateOfBirth, species));
    }
  }

  Customer _customerList = Customer('', '', '', '', DateTime.now(), '');
  Customer getCustomerList() => _customerList;
  void setCustomerList(List<dynamic> rawList) {
    for (var item in rawList) {
      var name = item['FullName'].toString();
      var phone = item['PhoneNumber'].toString();
      var address = item['Address'].toString();
      var gender = item['Gender'].toString();
      var dateofbirth = DateTime.parse(item['DateOfBirth'].toString());
      var password = item['Password'].toString();

      _customerList =
          Customer(phone, name, gender, address, dateofbirth, password);
    }
  }

  // UserData _userData = UserData('', '', '', '', '');
  // UserData getUserData() => _userData;
  // void setUserData(List<dynamic> rawList) {
  //   //_userData = [];
  //   for (var item in rawList) {
  //     var username = item['UserName'].toString();
  //     var fullname = item['FullName'].toString();
  //     var email = item['Email'].toString();
  //     var phonenumber = item['PhoneNumber'].toString();
  //     var address = item['Address'].toString();

  //     _userData = UserData(username, fullname, email, phonenumber, address);
  //   }
  // }

  // List<Device> _deviceList = [];
  // List<Device> getDeviceList() => _deviceList;
  // void setDeviceList(List<dynamic> rawList) {
  //   _deviceList = [];

  //   for (var item in rawList) {
  //     var code = item['Code'].toString();
  //     var serial = item['Serial'].toString();
  //     var contract = item['Contract'].toString();
  //     var owner = item['Owner'].toString();
  //     var ownedProduct = item['OwnedProduct'].toString();
  //     var base64Image = item['Image'].toString().replaceAll('\r\n', '');
  //     DateTime purchaseDate = DateTime.parse('00010101'.toString());
  //     if (item['PurchaseDate'] != "") {
  //       purchaseDate = DateTime.parse(item['PurchaseDate'].toString());
  //     }
  //     DateTime maintenanceTill = DateTime.parse('00010101'.toString());
  //     if (item['PurchaseDate'] != "") {
  //       maintenanceTill = DateTime.parse(item['MaintenanceTill'].toString());
  //     }
  //     List<NextMaintenance> nextMaintenanceList = [];
  //     for (var nextMaintenance in item['NextMaintenance']) {
  //       nextMaintenanceList.add(NextMaintenance(
  //           nextMaintenance['Detail'].toString(),
  //           nextMaintenance['Date'].toString()));
  //     }

  //     _deviceList.add(Device(
  //         code,
  //         serial,
  //         contract,
  //         owner,
  //         ownedProduct,
  //         base64ToImage(base64Image),
  //         purchaseDate,
  //         maintenanceTill,
  //         nextMaintenanceList));
  //   }
  // }

  // List<Product> _productList = [];
  // List<Product> getProductList() => _productList;
  // void setProductList(List<dynamic> rawList) {
  //   _productList = [];

  //   for (var item in rawList) {
  //     var name = item['Name'].toString();
  //     _productList.add(Product(name));
  //   }
  // }
}
