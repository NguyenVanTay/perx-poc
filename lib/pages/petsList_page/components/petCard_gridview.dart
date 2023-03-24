import 'package:dogs_park/pages/petsList_page/components/genderIcon.dart';
import 'package:flutter/material.dart';
import '../../../models/dogs.dart';
import '../../../utils/data_bucket.dart';
import '../../drawer_screen/configuration.dart';
import 'package:dogs_park/pages/petDetail_page/pet_detail_page.dart';

import 'QRcodeButtonForGridView.dart';

class PetCard_Grid extends StatefulWidget {
  int listIndex;

  PetCard_Grid({
    Key? key,
    required this.listIndex,
  }) : super(key: key);

  @override
  State<PetCard_Grid> createState() => _PetCard_GridState();
}

class _PetCard_GridState extends State<PetCard_Grid> {
  final List<Dog> _dogList = DataBucket.getInstance().getDogList();
  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;
    int listIndex = widget.listIndex;

    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.03),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PetDetail(
                        listIndex: listIndex,
                      )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                  width: maxWidth * (170 / 375),
                  height: maxHeight * (148 / 800),
                  child: FittedBox(
                      fit: BoxFit.fill, child: _dogList[listIndex].image)),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 5, right: 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _dogList[listIndex].dogName,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 26, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: maxWidth * (16 / 375)),
                    GenderIcon(gender: _dogList[listIndex].gender),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _dogList[listIndex].breed,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  fontSize: 12, color: const Color(0xFF000000)),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${_dogList[listIndex].age} years old',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontSize: 12),
                        ))
                  ],
                ),
                QRcodeButton(qrData: _dogList[listIndex].code),
              ],
            )
          ],
        ),
      ),
    );
  }
}
