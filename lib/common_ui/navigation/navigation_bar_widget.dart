// import 'package:flutter/material.dart';

// class NavigationBarWidget extends StatefulWidget {
//   const NavigationBarWidget(
//       {super.key,
//       required this.pages,
//       required this.labels,
//       required this.icons,
//       required this.activeIcons});

//   // 页面数组
//   final List<Widget> pages;
//   // 标签数组
//   final List<String> labels;
//   // 导航栏icon数组:切换前
//   final List<Widget> icons;
//   // 导航栏icon数组:切换后
//   final List<Widget> activeIcons;

//   @override
//   State<StatefulWidget> createState() {
//     return _NavigationBarWidgetState();
//   }
// }

// class _NavigationBarWidgetState extends State<NavigationBarWidget> {
//   int curentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//             child: IndexedStack(
//           index: curentIndex,
//           children: widget.pages,
//         )),
//         bottomNavigationBar: Theme(
//             data: Theme.of(context).copyWith(
//                 splashColor: Colors.transparent,
//                 highlightColor: Colors.transparent),
//             child: BottomNavigationBar(
//               type: BottomNavigationBarType.fixed,
//               selectedLabelStyle:
//                   TextStyle(fontSize: 13.sp, color: Colors.black),
//               unselectedLabelStyle:
//                   TextStyle(fontSize: 12.sp, color: Colors.blueGrey),
//               currentIndex: curentIndex,
//               items: _barItemList(),
//               onTap: (index) {
//                 curentIndex = index;
//                 setState(() {});
//               },
//             )));
//   }
// }
