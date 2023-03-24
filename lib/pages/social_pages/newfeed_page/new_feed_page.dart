// import 'package:flutter/material.dart';
// import 'components/globalFeedTabScreen.dart';

// import 'components/createPostScreen.dart';

// class NewFeedPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var theme = Theme.of(context);
//     return DefaultTabController(
//       length: 5,
//       child: Scaffold(
//         // appBar: TabBar(
//         //   physics: BouncingScrollPhysics(),
//         //   isScrollable: true,
//         //   indicatorColor: theme.primaryColor,
//         //   labelColor: theme.primaryColor,
//         //   unselectedLabelColor: ApplicationColors.black,
//         //   indicatorSize: TabBarIndicatorSize.label,
//         //   tabs: [
//         //     Tab(icon: Icon(Icons.search)),
//         //     Tab(text: S.of(context).following),
//         //     Tab(text: S.of(context).trending),
//         //     Tab(text: S.of(context).style),
//         //     Tab(text: S.of(context).travel),
//         //   ],
//         // ),
//         // body: TabBarView(
//         //   physics: BouncingScrollPhysics(),
//         //   children: [
//         //     GlobalFeedTabScreen(),
//         //     GlobalFeedTabScreen(),
//         //     GlobalFeedTabScreen(),
//         //     GlobalFeedTabScreen(),
//         //     GlobalFeedTabScreen(),
//         //   ],
//         // ),
//         body: GlobalFeedTabScreen(),
//         // floatingActionButton: CustomHomeFloatingActionButton(),
//         floatingActionButton: FloatingActionButton(
//             backgroundColor: theme.primaryColor,
//             child: Icon(Icons.add),
//             onPressed: () async {
//               await Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => CreatePostScreen2()));
//             }),
//       ),
//     );
//   }
// }
