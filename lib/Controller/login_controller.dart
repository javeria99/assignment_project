
import 'package:assigment_project/Constant/color.dart';
import 'package:assigment_project/Widget/snack._bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class LoginController extends GetxController {
  
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool validationLogin(context) {
    if (userNameController.text.isEmpty) {
      showCustomSnackbar('Warning', 'Kindly enter your user name', Colors.red);
      return false;
    } else if (passwordController.text.isEmpty) {
      showCustomSnackbar('Warning', 'Kindly enter your password', Colors.red);
      return false;
    }
    return true;
  }
  Future<void> login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'student.db');
    Database database = await openDatabase(path, version: 1);
    List<Map> userList = await database.rawQuery('SELECT * FROM User');
     bool checkflag = false;
      for (var user in userList) {
        if (user['name'] == userNameController.text && user['password']==passwordController.text) {
          prefs.setBool('didLogin', true);
        showCustomSnackbar(
            'Congratulation', 'Successfully Login', appMainColor);
        Get.offNamedUntil('/dashBoardPage', (route) => false);
            checkflag=true;
          break;
        } else {
          checkflag = false;
        }
      }
      if (checkflag == false) {
        showCustomSnackbar('Warning', 'Incorrect user name & password', Colors.red);
      } 
  }
}