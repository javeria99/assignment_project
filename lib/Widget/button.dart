import 'package:assigment_project/Constant/color.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class Button  extends StatelessWidget {

  final String buttonText;

  void Function()? onTap;

  Button({
    super.key,
    
    required this.buttonText,
    required this.onTap,
    
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
       width: 100,
       height: 50,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: buttonColor)
          
            ),
        child: Center(child: Text(buttonText,style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.center,))
      ),
    );
  }
}
