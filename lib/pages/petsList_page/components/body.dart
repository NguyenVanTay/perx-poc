import 'package:dogs_park/models/dogs.dart';
import 'package:dogs_park/pages/petsList_page/components/petCard_gridview.dart';
import 'package:dogs_park/pages/petsList_page/components/petCard_listview.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../utils/data_bucket.dart';
import '../../drawer_screen/configuration.dart';

class PetListBody extends StatefulWidget {
  const PetListBody({Key? key}) : super(key: key);

  @override
  State<PetListBody> createState() => _PetListBodyState();
}

class _PetListBodyState extends State<PetListBody> {
  final List<Dog> _dogList = DataBucket.getInstance().getDogList();
  @override
  Widget build(BuildContext context) {
    final double mainWidth = MediaQuery.of(context).size.width;
    final double mainHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.black),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {},
                ),
                Text(
                  'Pets list',
                  style:
                      AppTextStyle.daycarePackagesText.copyWith(fontSize: 20),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.black),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    setState(
                      () {
                        // enabled = !enabled;
                        // if enabled = false again, send api to update database
                      },
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mainWidth * (16 / 375),
                  vertical: mainHeight * (8 / 812)),
              child: Container(
                height: mainHeight * (36 / 812),
                width: mainWidth * (343 / 375),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFF4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  style: Theme.of(context).textTheme.titleSmall,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF8A8A8F),
                    ),
                    hintText: 'Search pet',
                    hintStyle: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ),
            SizedBox(
                height: mainHeight * 0.75,
                width: mainWidth,
                child: _dogList.length < 4 ? ListView3() : GridView4())
          ]),
    );
  }
}

class ListView3 extends StatelessWidget {
  ListView3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ScrollPhysics(),
      itemCount: DataBucket.getInstance().getDogList().length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return PetCard_List(listIndex: index);
      },
    );
  }
}

class GridView4 extends StatelessWidget {
  GridView4({Key? key}) : super(key: key);
  final List<Dog> _dogList = DataBucket.getInstance().getDogList();
  @override
  Widget build(BuildContext context) {
    final double mainWidth = MediaQuery.of(context).size.width;
    final double mainheight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        width: mainWidth * 0.9,
        height: mainheight * 0.75,
        padding: EdgeInsets.symmetric(horizontal: mainWidth * 0.01),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.75,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              crossAxisCount: 2),
          itemCount: _dogList.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredGrid(
              columnCount: 2,
              position: index,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  delay: const Duration(milliseconds: 100),
                  child: PetCard_Grid(listIndex: index),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
