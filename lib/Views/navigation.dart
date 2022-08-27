
import 'package:fitness/View_Model/naviagtion_viewmodel.dart';
import 'package:fitness/Views/rehab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../constants.dart';
import 'home.dart';


class Navigation extends StatelessWidget {
  final controller = Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
        return GetBuilder<NavigationController>(
          builder: (controller) {
            return Scaffold(
              body: SafeArea(
                child: IndexedStack(
                  index: controller.tabIndex,
                  children: [
                    const Home(),
                    const Rehab(),
                    Container(color: Colors.red,),
                    Container(color: Colors.blue,)
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedLabelStyle: sub1,
                unselectedItemColor: Color(0xff7A7A7A),
                selectedItemColor: Colors.black,
                onTap: controller.changeTabIndex,
                currentIndex: controller.tabIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Color(0xffF2F2F2),
                elevation: 0,
                items: [
                  _bottomNavigationBarItem(
                    icon: CupertinoIcons.calendar,
                    label: 'Home',
                  ),
                  _bottomNavigationBarItem(
                    icon: CupertinoIcons.person_3_fill,
                    label: 'Rehab',
                  ),
                  _bottomNavigationBarItem(
                    icon: CupertinoIcons.compass,
                    label: 'Practice',
                  ),
                  _bottomNavigationBarItem(
                    icon: CupertinoIcons.person,
                    label: 'Profile',
                  ),
                ],
              ),
            );
          }
        );
  }

  _bottomNavigationBarItem({IconData ?icon, String?label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,

    );
  }
}
