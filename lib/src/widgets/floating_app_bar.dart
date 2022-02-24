// import 'package:flutter/material.dart';
// import 'package:flutter_gmail_responsive/src/imports_files/import_configs.dart';
//
// class FloatAppBar extends StatelessWidget with PreferredSizeWidget {
//   const FloatAppBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Positioned(
//           top: 10,
//           right: 15,
//           left: 15,
//           child: Container(
//             color: Colors.white,
//             child: Row(
//               children: <Widget>[
//                 if (!Responsive.isDesktop(context) && !Responsive.isTablet(context)) Material(
//                   type: MaterialType.transparency,
//                   child: IconButton(
//                     splashColor: Colors.grey,
//                     icon: Icon(Icons.menu),
//                     onPressed: () {
//                       Scaffold.of(context).openDrawer();
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: TextField(
//                     cursorColor: Colors.black,
//                     keyboardType: TextInputType.text,
//                     textInputAction: TextInputAction.go,
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         contentPadding: EdgeInsets.symmetric(horizontal: 15),
//                         hintText: "Search..."),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
// }