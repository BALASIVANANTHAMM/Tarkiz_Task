import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Dashboard/MapScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final ctlMail=TextEditingController();
  final ctlPass=TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _postData(String Email,String Password) async {
    try {
      final response = await http.post(
        Uri.parse("http://tarkiz-chn-dev.southindia.cloudapp.azure.com:9000/api/Login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(<String, dynamic>{
          'emailId': Email,
          'password': Password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = await jsonDecode(response.body);
        setState(() {
          ctlMail.clear();
          ctlPass.clear();
        });
        if(responseData['statusCode']==200){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashboardScreen(
            responseImage: responseData['data']['profileImage'],
            firstName: responseData['data']['firstName'],
            lastName: responseData['data']['lastName'],
            driverId: responseData['data']['driverId'],)));
        }
        else{
          const snackdemo = SnackBar(
            content: Text('Check Your Id and Password'),
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackdemo);
        }
      } else {
        const snackdemo = SnackBar(
          content: Text('Login Error'),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      }
    } catch (e) {
      setState(() {
        final snackdemo = SnackBar(
          content: Text('Error $e'),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(50, 89, 244, 2),
      appBar: AppBar(
        leading: const Text(''),
        toolbarHeight: MediaQuery.of(context).size.height/8.2,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(21),topLeft: Radius.circular(21))
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.topLeft,
                child: Text(" Let's Get Started",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),),
              ),
              SizedBox(height: 6,),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('  fill this form to continue',style: TextStyle(
                    fontWeight: FontWeight.w400
                  ),)),
              const SizedBox(height: 50,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('   Email Address'),
                  Padding(
                    padding: const EdgeInsets.only(left: 12,right: 12),
                    child: TextFormField(
                      validator: validateEmail,
                      controller: ctlMail,
                      decoration: InputDecoration(
                          hintText: 'kial@gmail.com',
                          suffixIcon: const Icon(CupertinoIcons.person,color: Colors.grey,),
                          filled: true,
                          fillColor: Colors.black12,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(7)
                          )
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('   Password'),
                  Padding(
                    padding: const EdgeInsets.only(left: 12,right: 12),
                    child: TextFormField(
                      validator: validatePassword,
                      controller: ctlPass,
                      decoration: InputDecoration(
                          hintText: '•••••••',
                          suffixIcon: const Icon(CupertinoIcons.eye,color: Colors.grey,),
                          filled: true,
                          fillColor: Colors.black12,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(7)
                          )
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50,),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width-28,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(50, 89, 244, 2)
                  ),
                    onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _postData(ctlMail.text,ctlPass.text);
                    }
                    },
                    child: const Text('Login',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),)),
              )
            ],
          ),
        ),
      ),
    );
  }
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter an email address.';
    }
    RegExp emailRegex =
    RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!emailRegex.hasMatch(email)) {
      return 'Your Email Not Valid';
    }
    return null;
  }

// password validator
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter a password.';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%#?&])[A-Za-z\d@$!%#?&]{8,}$')
        .hasMatch(password)) {
      return 'Password should be in AlphaNumeric with Symbol Max 8';
    }
    return null;
  }
}
