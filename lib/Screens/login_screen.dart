import 'package:assigment_project/Constant/color.dart';
import 'package:assigment_project/Constant/constant.dart';
import 'package:assigment_project/Widget/button.dart';
import 'package:assigment_project/Widget/text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  

 

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
            text: 'New to student app? ',
            style: const TextStyle(
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: buttonColor),
                  text: 'Sign up now!',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.toNamed('/signUpPage')),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: appMainColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 4),
                  child: Column(
                    children: [
                      RoundedTextField(
                        circularRadius: 10,
                        controller: loginController.userNameController,
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
                        controller: loginController.passwordController,
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
                          buttonText: 'Login',
                          onTap: () {
                           bool validation=loginController.validationLogin(context);
                         if(validation==true){
                          loginController.login();
                         }
                          }),
                      
                    ],
                  ),
                )
              ],
            ),
          )
        
      
    );
  }
}
