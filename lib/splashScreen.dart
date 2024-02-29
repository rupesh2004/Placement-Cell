import 'dart:async';
import 'package:flutter/material.dart';
import 'package:company/loginPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        setState(() {
          _isLoading = false;
        });
         Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()));
       },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor:const Color.fromARGB(255, 174, 230, 242),
        
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/rit.jpg',
                fit: BoxFit.fill,
                width: double.infinity,
                height: 250,
              ),
              const SizedBox(height: 30,),
              const Text(
                'Placement Cell, RIT',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(
                          255, 5, 153, 158)), // Set the color to green
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
