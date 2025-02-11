import 'dart:async';

import 'package:assigment_project/Constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkPreference();
    Timer(
      const Duration(seconds: 5),
      () {
        Future(() {
          if (didLogin == true) {
            Get.offNamedUntil('/dashBoardPage', (route) => false);
          } else {
            Get.offNamedUntil('/loginPage', (route) => false);
          }
        });
      },
    );
    super.initState();
  }

  Future<void> checkPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    didLogin = (prefs.getBool('didLogin') ?? false);
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              stops: [0.2, 0.4, 0.9],
              end: Alignment.bottomLeft,
              colors: [
                Color(0xffffffff),
                Color.fromARGB(255, 1, 55, 99),
                Color(0xff91b79e)
              ],
            ),
          ),
          height: Get.height,
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 36,
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Image.asset(
                    'assets/topLeave.png',
                    height: Get.height * 0.30,
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Image.asset(
                  'assets/logo.png',
                  height: Get.height * 0.30,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/bottomLeave.png',
                      height: Get.height * 0.40,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
