
import 'package:assigment_project/Constant/color.dart';
import 'package:assigment_project/Constant/constant.dart';
import 'package:assigment_project/Widget/snack._bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
 
  final supabase = SupabaseClient(supBaseUrl, supBaseKey);

  String userName = userNameController.text;
  String password = passwordController.text;

  final response = await supabase
      .from('User')
      .select('id, name, password')
      .eq('name', userName)
      .eq('password', password)
      .single()
      .execute();

  if (response.error == null && response.data != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('didLogin', true);

    showCustomSnackbar('Congratulation', 'Successfully Login', appMainColor);

    Get.offNamedUntil('/dashBoardPage', (route) => false);
  } else {
    showCustomSnackbar('Warning', 'Incorrect user name & password', Colors.red);
  }
}
}