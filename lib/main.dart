import 'package:flutter/material.dart';
import 'package:spark/pages/home_page.dart';
import 'package:spark/pages/result_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home:  HomePage(),
    );
  }
}
