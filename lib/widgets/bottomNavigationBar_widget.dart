import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:kmshoppy/screens/home_screen.dart';
import '../db/db_functions.dart';
import '../db/db_model.dart';
import '../resources/app_utils.dart';
import '../screens/cart/my_cart.dart';

class BottomBarListWidget extends StatelessWidget {
  final bool inDetailPage;
  final int ind;
  const BottomBarListWidget({
    Key? key, required this.ind, required this.inDetailPage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child:  ValueListenableBuilder(valueListenable: cartListNotifier,
        builder: (BuildContext ctx,List<DbCartModel>cartList,Widget ? child){
         int iconCount = cartList.length;
        return  BottomNavigationBar(
          iconSize: 28,
          elevation: 3.0,
          currentIndex: ind,
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
          onTap: (index) {
            if(ind==0){
              if(index==2){
                navigateToPage(context,const MyCart(inDetail: false,));
              }
            }else{
              if(index==0){
                if(inDetailPage){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  print("indetail");
                  //Navigator.pop(context);
                }else{
                  Navigator.pop(context);
                }
               // navigateToPageRemove(context,const Homepage());
              }
            }
          },
          items:  [
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

                icon:Badge(
                  // position: BadgePosition(top: 0,bottom: 8),
                  //showBadge: true,
                  showBadge: iconCount == 0 ? false : true,
                  badgeColor: Colors.red[500]!,
                  badgeContent: Text(
                    iconCount.toString(),
                    style:const TextStyle(color: Colors.white),
                  ),
                  child:
                 const Icon(
                    Icons.shopping_cart,
                    //size: 25,
                  ),
                ),


                // Icon(
                //   Icons.shopping_cart,
                //   //size: 25,
                // ),
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
        );
        })

    );
  }
}
