import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../models/dogs.dart';
import '../../../../utils/data_bucket.dart';
import '../popUpWidget/component/customDropdownButton.dart';
import '../popUpWidget/component/customTextField.dart';

class PopUpWidget extends StatefulWidget {
  PopUpWidget({Key? key, required this.listIndex}) : super(key: key);

  int listIndex;

  @override
  State<PopUpWidget> createState() => _PopUpWidgetState();
}

class _PopUpWidgetState extends State<PopUpWidget> {
  bool isFavorite = false;
  final List<Dog> _dogList = DataBucket.getInstance().getDogList();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  GenderController genderController = GenderController();
  BreedController breedController = BreedController();
  Divider dividerBuilder() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 0,
      endIndent: 0,
      color: Color(0xFFEFEFF4),
    );
  }

  Future<void> showInformationDialog(
    BuildContext context,
    int listIndex,
    String name,
    String birth,
    String gender,
    String breed,
    String size,
  ) async {
    final double maxWidth = MediaQuery.of(context).size.width;
    List<String> petGenderList = ['Male', 'Female'];
    List<String> breedList = ['Retrievers (Golden)', 'Boxers', 'Bulldogs'];
    DateTime pickedDate = _dogList[listIndex].dateOfBirth;

    return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About Pet',
                      style: TextStyle(
                        color: Color(0xFF04CEBC),
                        fontSize: 17,
                        fontFamily: "SF Pro Display",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    dividerBuilder(),
                    CustomTextField(
                        title: 'Name',
                        value: _dogList[listIndex].dogName,
                        controllerName: _nameController),
                    dividerBuilder(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Birth',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  color: const Color(0xFF000000), fontSize: 15),
                        ),
                        SizedBox(
                          width: maxWidth * 0.3,
                          child: OutlinedButton(
                            style:
                                OutlinedButton.styleFrom(side: BorderSide.none),
                            onPressed: () {
                              DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                minTime: DateTime.now()
                                    .subtract(const Duration(days: 365000)),
                                maxTime: DateTime.now(),
                                onConfirm: (date) {
                                  setState(() {
                                    pickedDate = date;
                                  });
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.vi,
                              );
                            },
                            child: Text(
                              textAlign: TextAlign.end,
                              DateFormat('dd/MM/yyyy').format(pickedDate),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    dividerBuilder(),
                    CustomDropdownButton(
                        title: 'Gender',
                        list: petGenderList,
                        currentValue: _dogList[listIndex].gender),
                    dividerBuilder(),
                    CustomDropdownButton(
                        title: 'Breed',
                        list: breedList,
                        currentValue: _dogList[listIndex].breed),
                    dividerBuilder(),
                    CustomTextField(
                        title: 'Weight (kg)',
                        value: _dogList[listIndex].weight,
                        controllerName: _weightController),
                  ],
                ),
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.2),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFF04cebc),
                      ),
                      child: Center(
                        child: Text(
                          'Confirm',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int listIndex = widget.listIndex;

    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      iconSize: 30,
      onPressed: () async {
        await showInformationDialog(
            context, listIndex, 'name', 'birth', 'Male', 'breed', 'Weight');
      },
      icon: const Icon(
        Icons.more_horiz_rounded,
        color: Colors.white,
      ),
    );
  }
}

class GenderController extends GetxController {
  RxString dropdownValue = "".obs;
  List<String> genderList = ['Male', 'Female', 'Other'];

  void setSelected(String value) {
    dropdownValue.value = value;
  }
}

class BreedController extends GetxController {
  RxString dropdownValue = "".obs;
  List<String> breedList = ['Retrievers (Golden)', 'Boxers', 'Bulldogs'];

  void setSelected(String value) {
    dropdownValue.value = value;
  }
}
