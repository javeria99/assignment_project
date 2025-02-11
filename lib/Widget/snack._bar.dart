import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar(String title, String message,Color color) {
  Get.snackbar(title, message,
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: color,
                              titleText: Center(child: Text(title,style: const TextStyle(fontWeight: FontWeight.w900,fontSize: 20),)),
                              messageText:  Center(child: Text(message,style: const TextStyle(fontSize: 16),)),
                              snackStyle: SnackStyle.FLOATING
                              );
}