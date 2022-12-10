import 'package:flutter/material.dart';
import 'package:kmshoppy/db/db_model.dart';
import 'package:kmshoppy/provider/feturedItem_provider.dart';
import 'package:kmshoppy/provider/slider_provider.dart';
import 'package:kmshoppy/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'package:hive_flutter/hive_flutter.dart';
void main() {
  Hive.initFlutter();
  if(!Hive.isAdapterRegistered(DbCartModelAdapter().typeId)){ 
    Hive.registerAdapter(DbCartModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ItemProvider()),
        ChangeNotifierProvider(create: (context) => SliderProvider()),
      ],
      child: MaterialApp(
        title: 'Kmshoppy',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const Homepage(),
      ),
    );
  }
}
