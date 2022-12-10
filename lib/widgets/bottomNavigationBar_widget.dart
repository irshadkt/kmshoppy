import 'package:flutter/material.dart';

class BottomBarListWidget extends StatelessWidget {
  const BottomBarListWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: BottomNavigationBar(
        iconSize: 28,
        elevation: 3.0,
        currentIndex: 0,
        backgroundColor: Colors.white,
        //fixedColor: Colors.black,
        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
          color: Colors.grey,
          fontWeight: FontWeight.w700,
        ),
        showUnselectedLabels:true ,
        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
       // unselectedLabelStyle: FontWeight.bold,
        selectedIconTheme: const IconThemeData(
          color: Colors.indigo,
        ),
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                //size: 25,
              ),
              label: "Home"),

          BottomNavigationBarItem(
              icon: Icon(
                Icons.category_outlined,
                //size: 25,
                // color: Colors.black,
              ),
              label: "Category"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                //size: 25,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search_rounded,
               // size: 25,
                // color: Colors.black,
              ),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                //size: 25,
                //color: Colors.black,
              ),
              label: "Profile"),

        ],
      ),
    );
  }
}
