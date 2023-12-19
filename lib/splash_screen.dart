import 'package:flutter/material.dart';
import 'dart:async';

import 'package:gpvariedadesemgeral/my_website.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 3),
          () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyWebsite(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(99, 176, 206, 40),
      body: Center(
        child: Image.asset(
          'assets/img4.gif',
          height: 200,
        ),
      ),
    );
  }
}