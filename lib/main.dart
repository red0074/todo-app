import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todoapp_project1/pages/home_page.dart';

void main() async {
  //initializa the hive
  await Hive.initFlutter();
  //open a box
  var box = await Hive.openBox('box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}
