import 'package:flutter/cupertino.dart';

class Dog {
  const Dog(
      this.code,
      this.dogName,
      this.owner,
      this.breed,
      this.gender,
      this.image,
      this.weight,
      this.sterilized,
      this.age,
      this.microchip,
      this.furColor,
      this.dateOfBirth,
      this.species);
  final String code;
  final String dogName;
  final String owner;
  final String breed;
  final String gender;
  final Image image;
  final String weight;
  final String sterilized;
  final String age;
  final String microchip;
  final String furColor;
  final DateTime dateOfBirth;
  final String species;
}

class HealthStatus{
  final DateTime starttime;
  final DateTime endtime;
  final String healthstatus;
  final double weight;
  final String veterinarian;

  const HealthStatus(
    this.starttime,
    this.endtime,
    this.healthstatus,
    this.weight,
    this.veterinarian
  );
}

class InjectionHistory{
  final DateTime date;
  final double weight;
  final String vaccinelabel;
  final DateTime nextvaccination;
  final String veterinarian;
  final String disease;
  
  const InjectionHistory(
    this.date,
    this.weight,
    this.vaccinelabel,
    this.nextvaccination,
    this.veterinarian,
    this.disease
  );
}

class LouseDogTreatment{
  final DateTime date;
  final String product;
  final int quantity;
  final String veterinarian;
  
  const LouseDogTreatment(
    this.date,
    this.product,
    this.quantity,
    this.veterinarian
  );
}