import 'package:dogs_park/pages/drawer_screen/configuration.dart';
import 'package:flutter/material.dart';

import '../../widgets/gradient_app_bar_color.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

// ignore: must_be_immutable
class PetDetails extends StatefulWidget {
  PetDetails({Key? key, required this.catDetailsMap}) : super(key: key);

  Map catDetailsMap;

  @override
  _PetDetailsState createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {
  bool isFavorite = false;
  int _bottomNavIndex = 0;

  List<IconData> iconList = [
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    final double mainWidth = MediaQuery.of(context).size.width;
    final double mainheight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pet Profile'),
          centerTitle: true,
          flexibleSpace: const GradientAppBarColor(),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                        tag: 'pet${widget.catDetailsMap['id']}',
                        child: Image.asset(
                          widget.catDetailsMap['imagePath'],
                          fit: BoxFit.contain,
                          width: mainWidth * 0.6,
                          height: mainheight * 0.2,
                          colorBlendMode: BlendMode.color,
                        )),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                boxShadow: shadowList,
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 10, bottom: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.catDetailsMap['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26.0,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        (widget.catDetailsMap['sex'] == 'male')
                                            ? Icon(
                                                Icons.male_rounded,
                                                color: Colors.grey[500],
                                                size: 30,
                                              )
                                            : Icon(
                                                Icons.female_rounded,
                                                color: Colors.grey[500],
                                                size: 30,
                                              ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.catDetailsMap['Species'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[500],
                                            letterSpacing: 0.7,
                                          ),
                                        ),
                                        Text(
                                          widget.catDetailsMap['year'] +
                                              ' years old',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[500],
                                            letterSpacing: 0.7,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // const SizedBox(height: 2),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: primaryColor,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          widget.catDetailsMap['location'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[400],
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            DefaultTabController(
                              length: 4,
                              child: Column(children: [
                                const TabBar(
                                    isScrollable: true,
                                    labelColor: Color(0xFF04CEBC),
                                    unselectedLabelColor: Colors.black,
                                    indicatorColor: Color(0xFF04CEBC),
                                    indicatorWeight: 5,
                                    indicatorPadding:
                                        EdgeInsets.fromLTRB(0, 6, 0, 0),
                                    tabs: [
                                      Tab(text: 'Health status'),
                                      Tab(text: 'Treatment'),
                                      Tab(text: 'Injection'),
                                      Tab(text: 'History'),
                                    ]),
                                Container(
                                    height: mainheight * 0.4,
                                    child: const TabBarView(
                                        physics: BouncingScrollPhysics(),
                                        //dragStartBehavior: DragStartBehavior.down,
                                        children: [
                                          Text(
                                            "tab1",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "tab2",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "tab3",
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "tab4",
                                            textAlign: TextAlign.center,
                                          ),
                                        ])),
                              ]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("QR code"),
                        ));
                      },
                      icon: const Icon(
                        Icons.qr_code_2,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.,
            //   child:

            //),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //Navigator.push(context, PageTransition(child: const ScanPage(), type: PageTransitionType.bottomToTop));
          },
          backgroundColor: Colors.grey,
          splashColor: const Color(0xff04CEBC),
          child: const Icon(
            Icons.add_circle_rounded,
            color: Colors.black87,
            size: 35,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
            backgroundColor: Colors.grey,
            splashColor: const Color(0xff04CEBC),
            activeColor: const Color(0xff04CEBC),
            inactiveColor: Colors.black87,
            icons: iconList,
            activeIndex: _bottomNavIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            onTap: (index) {
              setState(() {
                _bottomNavIndex = index;
                // final List<Plant> favoritedPlants = Plant.getFavoritedPlants();
                // final List<Plant> addedToCartPlants = Plant.addedToCartPlants();
                // favorites = favoritedPlants;
                // myCart = addedToCartPlants.toSet().toList();
              });
            }));
  }
}
