import 'package:dogs_park/pages/petDetail_page/components/popUpWidget/body.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/dogs.dart';
import '../../../utils/data_bucket.dart';
import '../../petsList_page/components/QRcodeButton.dart';
import '../components/customDropdownRow.dart';
import '../components/customRowComponent.dart';

class Body extends StatefulWidget {
  Body({Key? key, required this.listIndex}) : super(key: key);

  int listIndex;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isFavorite = false;
  final List<Dog> _dogList = DataBucket.getInstance().getDogList();

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;
    int listIndex = widget.listIndex;

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                color: (listIndex % 2 == 0)
                    ? Colors.blueGrey[200]
                    : const Color.fromARGB(255, 27, 119, 107),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ClipRRect(
                      child: FittedBox(
                    fit: BoxFit.fill,
                    child: _dogList[listIndex].image,
                  )),
                ),
              ),
              Positioned(
                top: maxHeight * 0.01,
                right: maxWidth * 0.02,
                child: PopUpWidget(listIndex: listIndex),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: maxWidth * 0.048, vertical: maxWidth * 0.048),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          _dogList[listIndex].dogName,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 28, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      QRcodeButton(qrData: _dogList[listIndex].code),
                    ],
                  ),
                ),
              ),
            ],
          ),
          CustomDropdownRow(
            title: 'About Pet',
            componentsList: [
              CustomRowComponent(
                  title: 'Birth',
                  value: DateFormat('dd/MM/yyyy')
                      .format(_dogList[listIndex].dateOfBirth)),
              CustomRowComponent(
                  title: 'Gender', value: _dogList[listIndex].gender),
              CustomRowComponent(
                  title: 'Breed', value: _dogList[listIndex].breed),
              CustomRowComponent(
                  title: 'Weight', value: _dogList[listIndex].weight),
            ],
            initiallyExpanded: true,
          ),
          CustomDropdownRow(
            title: 'Injection History',
            componentsList: [
              CustomRowComponent(title: 'Injection name', value: '25-08-2022'),
              CustomRowComponent(title: 'Injection name', value: '25-08-2022'),
              CustomRowComponent(title: 'Injection name', value: '25-08-2022'),
              CustomRowComponent(title: 'Injection name', value: '25-08-2022'),
            ],
          ),
          CustomDropdownRow(
            title: 'Health Care',
            componentsList: [
              CustomRowComponent(title: 'HealthCare name', value: '25-08-2022'),
              CustomRowComponent(title: 'HealthCare name', value: '25-08-2022'),
              CustomRowComponent(title: 'HealthCare name', value: '25-08-2022'),
              CustomRowComponent(title: 'HealthCare name', value: '25-08-2022'),
            ],
          ),
          CustomDropdownRow(
            title: 'Louse Treatment',
            componentsList: [
              CustomRowComponent(title: 'Louse Treatment', value: '25-08-2022'),
              CustomRowComponent(title: 'Louse Treatment', value: '25-08-2022'),
              CustomRowComponent(title: 'Louse Treatment', value: '25-08-2022'),
              CustomRowComponent(title: 'Louse Treatment', value: '25-08-2022'),
            ],
          ),
        ],
      ),
    );
  }
}
