import 'dart:async';
import 'package:practicle_task/Screen/ProductPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

var newLaunch;

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 3;
  bool loginsuccess = false;

  checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool newLaunchh = ((prefs.getBool('newLaunch') ?? false));
    newLaunch = newLaunchh;
    print(newLaunch);
    if (newLaunch) {
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) {
          return const ProductList();
        
        })));
      }
    } else {
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) {
          return const LoginPage();
        
          //            return const HomeActivity();
        })));
      }
    }
  }

  _loadWidget() async {
    var duration = Duration(seconds: splashDelay);
    return Timer(duration, checkFirstSeen);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _loadWidget();
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Product Cart',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
