import 'package:dogs_park/widgets/gradient_app_bar_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../pages/petDetail_page/components/body.dart';

class PetDetail extends StatefulWidget {
  int listIndex;

  PetDetail({Key? key, required this.listIndex}) : super(key: key);

  @override
  State<PetDetail> createState() => _PetDetailState();
}

class _PetDetailState extends State<PetDetail> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  bool enabled = false;

  @override
  Widget build(BuildContext context) {
    int listIndex = widget.listIndex;

    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.black),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          title: const Text(
            'Pet profile',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
          flexibleSpace: const GradientAppBarColor(),
        ),
        body: SafeArea(child: Body(listIndex: listIndex)));
  }
}
