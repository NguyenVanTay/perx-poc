import 'package:dogs_park/pages/petsList_page/components/QRcodeButton.dart';
import 'package:dogs_park/pages/petsList_page/components/genderIcon.dart';
import 'package:flutter/material.dart';

import '../../../models/dogs.dart';
import '../../../utils/data_bucket.dart';
import '../../drawer_screen/configuration.dart';
import 'package:dogs_park/pages/petDetail_page/pet_detail_page.dart';

class PetCard_List extends StatefulWidget {
  int listIndex;

  PetCard_List({
    required this.listIndex,
  });

  @override
  State<PetCard_List> createState() => _PetCard_ListState();
}

class _PetCard_ListState extends State<PetCard_List> {
  final List<Dog> _dogList = DataBucket.getInstance().getDogList();
  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;
    int listIndex = widget.listIndex;
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.04),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PetDetail(
                        listIndex: listIndex,
                      )));
        },
        child: SizedBox(
          width: maxWidth,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: maxHeight * (28 / 812)),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: maxWidth * (145 / 375),
                    height: maxHeight * (143 / 812),
                    child: FittedBox(
                        fit: BoxFit.fill, child: _dogList[listIndex].image),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: maxHeight * (20 / 812),
                        bottom: maxHeight * (20 / 812),
                        left: maxWidth * (21 / 375)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                _dogList[listIndex].dogName,
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontFamily: "SF Pro Display",
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: maxWidth * (17.89 / 375)),
                            GenderIcon(gender: _dogList[listIndex].gender),
                          ],
                        ),
                        SizedBox(height: maxHeight * (20 / 812)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _dogList[listIndex].breed,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            fontSize: 15, color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${_dogList[listIndex].age} years old',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            fontSize: 15,
                                            color: const Color(0xFF8A8A8F)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            QRcodeButton(qrData: _dogList[listIndex].code),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: Color(0xFFEFEFF4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
