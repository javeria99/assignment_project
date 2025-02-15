import 'package:assigment_project/Constant/color.dart';
import 'package:assigment_project/Widget/snack._bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  // await Supabase.initialize(
  //   url: supBaseUrl,
  //   anonKey: supBaseKey
  // );

  String name = nameController.text;

  final response = await Supabase.instance.client
      .from('User') 
      .select('id')
      .eq('name', name) 
      .execute();

  if (response.error == null && response.data != null && response.data.isNotEmpty) {
    showCustomSnackbar('Warning', 'User already exists', Colors.red);
  } else {
    final signUpResponse = await Supabase.instance.client.auth.signUp(
      nameController.text, 
      passwordController.text, 
    );

    if (signUpResponse.error == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('didLogin', true);

      showCustomSnackbar('Congratulation', 'Successfully Sign up', appMainColor);

      Get.offNamedUntil('/dashBoardPage', (route) => false);
    } else {
      showCustomSnackbar('Error', 'Failed to sign up: ${signUpResponse.error?.message}', Colors.red);
    }
  }
}
}
