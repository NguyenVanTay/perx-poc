// import 'package:dogs_park/pages/home_screens/pet_details.dart';
// import 'package:flutter/material.dart';

// import '../drawer_screen/configuration.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   double xOffset = 0;
//   double yOffset = 0;
//   double scaleFactor = 1;

//   bool isDrawerOpen = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: AnimatedContainer(
//       decoration: isDrawerOpen
//           ? BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(25),
//             )
//           : const BoxDecoration(color: Colors.white),
//       transform: Matrix4.translationValues(xOffset, yOffset, 0)
//         ..scale(scaleFactor),
//       duration: const Duration(milliseconds: 250),
//       child: SingleChildScrollView(
//         child: SafeArea(
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 10.0,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: const BorderRadius.only(
//                       topRight: Radius.circular(25),
//                       topLeft: Radius.circular(25)),
//                 ),
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 30.0,
//                     ),
//                     Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 15.0),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           enabledBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: Colors.transparent),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: primaryColor),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           prefixIcon: Icon(
//                             Icons.search,
//                             color: Colors.grey[400],
//                           ),
//                           hintText: 'Search pet',
//                           hintStyle: TextStyle(
//                               letterSpacing: 1, color: Colors.grey[400]),
//                           filled: true,
//                           fillColor: Colors.white,
//                           suffixIcon:
//                               Icon(Icons.tune_sharp, color: Colors.grey[400]),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 30.0,
//                     ),
//                     const SizedBox(
//                       height: 20.0,
//                     ),
//                     ListView.builder(
//                       physics: const ScrollPhysics(),
//                       itemCount: catMapList.length,
//                       scrollDirection: Axis.vertical,
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => PetDetails(
//                                           catDetailsMap: catMapList[index],
//                                         )));
//                           },
//                           child: Container(
//                             height: 230,
//                             margin: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Stack(
//                                     children: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           color: (index % 2 == 0)
//                                               ? Colors.blueGrey[200]
//                                               : Colors.orangeAccent[200],
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                           boxShadow: shadowList,
//                                         ),
//                                         margin: const EdgeInsets.only(top: 40),
//                                       ),
//                                       Align(
//                                           child: Padding(
//                                         padding: const EdgeInsets.only(top: 40),
//                                         child: Hero(
//                                             tag:
//                                                 'pet${catMapList[index]['id']}',
//                                             child: Image.asset(catMapList[index]
//                                                 ['imagePath'])),
//                                       )),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     margin: const EdgeInsets.only(
//                                         top: 65, bottom: 20),
//                                     padding: const EdgeInsets.all(15),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: const BorderRadius.only(
//                                           topRight: Radius.circular(20),
//                                           bottomRight: Radius.circular(20)),
//                                       boxShadow: shadowList,
//                                     ),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(
//                                               catMapList[index]['name'],
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 21.0,
//                                                 color: Colors.grey[600],
//                                               ),
//                                             ),
//                                             (catMapList[index]['sex'] == 'male')
//                                                 ? Icon(
//                                                     Icons.male_rounded,
//                                                     color: Colors.grey[500],
//                                                   )
//                                                 : Icon(
//                                                     Icons.female_rounded,
//                                                     color: Colors.grey[500],
//                                                   ),
//                                           ],
//                                         ),
//                                         Text(
//                                           catMapList[index]['Species'],
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.grey[500],
//                                           ),
//                                         ),
//                                         Text(
//                                           catMapList[index]['year'] +
//                                               ' years old',
//                                           style: TextStyle(
//                                             fontSize: 12,
//                                             color: Colors.grey[400],
//                                           ),
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             Icon(
//                                               Icons.calendar_month,
//                                               color: primaryColor,
//                                               size: 18,
//                                             ),
//                                             const SizedBox(
//                                               width: 3,
//                                             ),
//                                             Text(
//                                               catMapList[index]['distance'],
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.grey[400],
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
