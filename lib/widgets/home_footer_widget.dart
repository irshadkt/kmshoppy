import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors.dart';
class HomeFooter extends StatelessWidget {
  const HomeFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding:const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: secondaryYellow,
            // border: Border.all(
            //     color:
            //     Color.fromRGBO(211, 211, 207, 1)),
            borderRadius: BorderRadius.circular(12)),
        //height: 50,
        margin:const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width/2,
              child: Column(
                children: [
                  iconWithText("Get things delivered to your doorstep", Icons.delivery_dining),
                  iconWithText("No Minimum order value on your purchase", Icons.currency_rupee_outlined),
                  iconWithText("Operation hours :       08:00 AM - 10:00 PM", Icons.watch),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding iconWithText(String text,IconData icon) {
    return Padding(
                padding: const EdgeInsets.all(0.0),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.greenAccent,
                    child: Center(
                      child: Icon(
                        icon,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                    ),
                  ),
                  title: Text(
                    text,
                    style: GoogleFonts.nunitoSans(
                        color: Colors.indigo,fontSize: 14,fontWeight: FontWeight.w800),
                  ),
                ),

              );
  }
}