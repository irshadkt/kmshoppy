import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kmshoppy/resources/urls.dart';
Widget appLoading({double? value}) {
  return CircularProgressIndicator(
    value: value,
    color: Colors.white,
    backgroundColor: Colors.redAccent,
  );
}

Future<bool> isConnected() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
}
void showMessage(String message, Color colorBackground, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration:const Duration(seconds: 5),
      backgroundColor: colorBackground,
      content: Text(
        message,
        style: GoogleFonts.nunitoSans(letterSpacing: 0.8),
      ),
    ),
  );
}
Future navigateToPageRemove(context, var page) {
  return Navigator.pushAndRemoveUntil(
    context,
    createRoute(page),
        (route) => false,
  );
}
Route createRoute(var page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
Future navigateToPage(context, var page) {
  return Navigator.of(context).push(createRoute(page));

}
Widget buildNetworkImage(BuildContext context,
    String? image, {
      BoxFit boxFit = BoxFit.contain,
    }) {
  return Container(
    width: MediaQuery.of(context).size.height/4,
    height: MediaQuery.of(context).size.height/4,
    //width: MediaQuery.of(context),
    //width: double.infinity,
     color: Colors.blueGrey,
    margin:const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: image != null
        ? CachedNetworkImage(
      imageUrl: "$mediaUrl$image",
      fit: boxFit,
      progressIndicatorBuilder: (ctx, url, progress) => Center(
        child: appLoading(value: progress.progress),
      ),
      errorWidget: (context, url, error) => Icon(Icons.image),
    )
        : Icon(Icons.image),
    //Image.asset(noImage),
  );
}