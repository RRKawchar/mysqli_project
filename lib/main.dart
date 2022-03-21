import 'package:flutter/material.dart';
import 'package:mysql_database/php_server/login_page.dart';
import 'package:mysql_database/php_server/userOne.dart';
import 'package:mysql_database/product/productOne.dart';
import 'package:mysql_database/student/loginScreen.dart';
import 'package:mysql_database/student/student_information.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserOne(),
    );
  }
}

