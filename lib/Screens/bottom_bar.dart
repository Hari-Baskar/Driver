import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Commons/constant_strings.dart';
import 'package:driver/Screens/emergency.dart';
import 'package:driver/Screens/history.dart';
import 'package:driver/Screens/home.dart';
import 'package:driver/Screens/passengers.dart';
import 'package:driver/Screens/route.dart';
import 'package:flutter/material.dart';
class  BottomBar extends StatefulWidget {
  const  BottomBar({super.key});

  @override
  State< BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State< BottomBar> {
  var index=0;
  List Screen=[Home(),Passengers(),RoutePath(),Emergency(),History()];
  int i=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Screen[i],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: i,
          onTap: (index){
          setState(() {
            i=index;
          });

          },
          items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: home
          
        ),
        BottomNavigationBarItem(icon: Icon(Icons.group),  label: passengers),
        BottomNavigationBarItem(icon: Icon(Icons.alt_route_rounded),  label: route),
        BottomNavigationBarItem(icon: Icon(Icons.bus_alert),  label: emergency),
        BottomNavigationBarItem(icon: Icon(Icons.history),  label: history),

      ],
      selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}
