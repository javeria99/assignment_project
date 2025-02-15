import 'package:assigment_project/Constant/constant.dart';
import 'package:assigment_project/Widget/button.dart';
import 'package:assigment_project/Widget/text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constant/color.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 1, 55, 99),
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: MediaQuery.of(context).size.width,
          color: appMainColor,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Already have an account? ',
              style: const TextStyle(
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: buttonColor),
                    text: 'Login!',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.back();
                      }),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: GestureDetector(
                          onTap: () => Get.back(),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 40,
                          )),
                    ),
                    Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                            color: appMainColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                child: Column(
                  children: [
                    RoundedTextField(
                      circularRadius: 10,
                      controller: signUpController.nameController,
                      borderColor: appMainColor,
                      textColor: appMainColor,
                      readOnly: false,
                      cursorColor: appMainColor,
                      keyBoardType: TextInputType.emailAddress,
                      hintText: 'Email',
                      hintColor: appMainColor,
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: appMainColor,
                      obscureText: false,
                      horizontalPadding: 20,
                      backgroundColor: Colors.white24,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    RoundedTextField(
                      circularRadius: 10,
                      controller: signUpController.passwordController,
                      borderColor: appMainColor,
                      textColor: appMainColor,
                      readOnly: false,
                      cursorColor: appMainColor,
                      keyBoardType: TextInputType.text,
                      hintText: 'Password',
                      hintColor: appMainColor,
                      prefixIcon: const Icon(Icons.key),
                      prefixIconColor: appMainColor,
                      obscureText: true,
                      horizontalPadding: 20,
                      backgroundColor: Colors.white24,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Button(
                        buttonText: 'Sign Up',
                        onTap: () async {
                         bool validation=signUpController.validationSignUp(context);
                         if(validation==true){
                          signUpController.signUp();
                         }
                        }),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
