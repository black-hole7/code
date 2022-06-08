import 'package:flutter/material.dart';
import 'package:gim/login.dart';
import 'package:gim/register.dart';
import 'package:gim/resetpass.dart';
import 'package:gim/home.dart';
import 'package:gim/order.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      title: 'اخدم بلدك',
      routes: {
        'home': (context) => myHome(),
        'login': (context) => myLogin(),
        'register': (context) => myRegister(),
        'forgot': (context) => resetPassword(),
        'order': (context) => myOrder(),
      },
    ),
  );

  await Firebase.initializeApp();
}
