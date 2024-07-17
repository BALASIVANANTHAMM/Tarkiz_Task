import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height/2.5,
                width: MediaQuery.of(context).size.width-100,
                child: Image.asset('assets/delivery.jpeg')),
            const SizedBox(height: 10,),
            const Text('Elevating Delivery Standards',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22
            ),),
            const SizedBox(height: 3,),
            const Text('Lorem Ipsum Dolor Sit Amet, Consectetur'),
            const Text('Adipiscing Elit, Sed Do Eiusmod'),
            SizedBox(height: MediaQuery.of(context).size.height/4,),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width-100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(50, 89, 244, 2)
                ),
                  onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  },
                  child: const Text("Let's Start",style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),)),
            ),
            const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
