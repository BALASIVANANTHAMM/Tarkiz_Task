import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';

import '../Authentication Page/StartScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>const StartScreen(),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(50, 89, 244, 2),
        body:SafeArea(child:  Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            SizedBox(height: MediaQuery.of(context).size.height/8,
              width:  MediaQuery.of(context).size.width/5,
              child: const Iconify(Carbon.scooter,color: Colors.white,),
              ),
                const Text('DRIVER DXB',style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),)
          ]
          ),
        ),
        ));
  }
}