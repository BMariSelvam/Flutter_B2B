import 'package:b2b/Helper/assets.dart';
import 'package:b2b/Helper/fonts.dart';
import 'package:flutter/material.dart';

import '../../Helper/colors.dart';
import '../../checking.dart';
import '../../MyProfile_Screen.dart';
import '../DashBoard/dashboardscreen.dart';
import '../Order/orderscreen.dart';
import '../Product/productscreen.dart';
import '../Support/Setting_Screen.dart';

class BottomNavBar extends StatefulWidget {
  int? intex;

  BottomNavBar({
    this.intex = 0,
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  initState() {
    super.initState();
  }

  onItemTapped(int index) {
    print(index);
    print(widget.intex);
    setState(() {
      widget.intex = index;
    });
  }

  List<Widget> tab = [
    const DashBoardScreen(),
    const ProductScreen(),
    const OrderScreen(),
    const SupportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.intex,
        children: tab,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        unselectedLabelStyle: TextStyle(
          fontFamily: MyFont.myFont,
          fontSize: 10,
          color: MyColors.lightBlue,
        ),
        unselectedItemColor: MyColors.lightBlue,
        selectedLabelStyle: TextStyle(
          fontFamily: MyFont.myFont,
          fontSize: 10,
        ),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'DashBoard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.content_paste_search_rounded),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: widget.intex!,
        selectedItemColor: MyColors.mainTheme,
        onTap: onItemTapped,
      ),
    );
  }
}
