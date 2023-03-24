import 'package:dogs_park/utils/data_bucket.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';

import '../../../models/dogs.dart';

final dogList = DataBucket.getInstance().getDogList();

class DogOption extends StatelessWidget {
  final int idDog;
  const DogOption({Key? key, required this.idDog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = 0;
    for (int i = 0; i < dogList.length; i++) {
      if (idDog == int.parse(dogList[i].code.toString())) {
        index = i;
        break;
      }
    }
    final Dog dog = dogList[index];
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: dog.image,
        ),
        Text(dog.dogName + " - " + dog.weight + " kg",
            style: AppTextStyle.daycareSelection),
      ],
    );
  }
}
