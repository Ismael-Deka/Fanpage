import 'dart:async';

import 'package:fanpage/signinscreen.dart';
import 'package:fanpage/messagescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'authenticationservice.dart';


class SplashScreen extends StatefulWidget{


  const SplashScreen({Key? key}) : super(key: key);


  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
 


} 
class _SplashScreenState extends State<SplashScreen>{
  final Image mSplashPic = Image.asset("images/splashpic.jpg",height: 450);

  @override
  void initState() {
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                SignInScreen()
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          height: 500,
          child: Column(
            children: [
              mSplashPic,
              const Text(
                "Welcome to my Fan Club!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  backgroundColor: Colors.white),
              )
            ],
        )
      )
    );

  }

}

