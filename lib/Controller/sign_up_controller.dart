import 'package:assigment_project/Constant/color.dart';
import 'package:assigment_project/Widget/snack._bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class SignUpController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool validationSignUp(context) {
    if (nameController.text.isEmpty) {
      showCustomSnackbar('Warning', 'Kindly enter your user name', Colors.red);
      return false;
    } else if (passwordController.text.isEmpty) {
      showCustomSnackbar('Warning', 'Kindly enter your password', Colors.red);
      return false;
    }
    return true;
  }

  Future<void> signUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'student.db');
    Database database = await openDatabase(path, version: 1);
    List<Map> userList = await database.rawQuery('SELECT * FROM User');
    if (userList.isEmpty) {
      await database.rawInsert(
          'INSERT INTO User(name, password) VALUES("$nameController.text}", "${passwordController.text}")');
      prefs.setBool('didLogin', true);
      showCustomSnackbar(
          'Congratulation', 'Successfully Sign up', appMainColor);
      Get.offNamedUntil('/dashBoardPage', (route) => false);
    } else {
      bool checkflag = false;
      for (var user in userList) {
        if (user['name'] == nameController.text) {
          checkflag = false;
        } else {
          checkflag = true;
        }
      }
      if (checkflag == true) {
        await database.rawInsert(
            'INSERT INTO User(name, password) VALUES("${nameController.text}", "${passwordController.text}")');
        prefs.setBool('didLogin', true);
        showCustomSnackbar(
            'Congratulation', 'Successfully Sign up', appMainColor);
          Get.offNamedUntil('/dashBoardPage', (route) => false);
      } else {
        showCustomSnackbar('Warning', 'User already exist', Colors.red);
      }
    }
    await database.close();
  }
}
