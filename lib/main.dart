import 'dart:ui';

import 'package:chat/screens/authScreen.dart';
import 'package:chat/screens/chatScreen.dart';
import 'package:chat/screens/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        )
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged,
      builder:(ctx,userSnapshot){
        if(userSnapshot.connectionState==ConnectionState.waiting){
          return SplashScreen();
        }
        if(userSnapshot.hasData){
          return ChatScreen();
        }
        return AuthScreen();
      },),
    );
  }
}

