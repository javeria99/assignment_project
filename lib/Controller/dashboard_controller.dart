
import 'package:assigment_project/Constant/color.dart';
import 'package:assigment_project/Widget/snack._bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardController extends GetxController {
    var studentList = <Map>[].obs;
    RxMap<dynamic, dynamic> student = <String, dynamic>{}.obs;
    var courseList = <Map>[].obs;
 Future<void> getStudent() async {
  // await Supabase.initialize(
  //   url: supBaseUrl,
  //   anonKey: supBaseKey
  // );
  final response = await Supabase.instance.client
      .from('Student') 
      .select() 
      .execute(); 

  if (response.error != null) {
    showCustomSnackbar('Error', 'Failed to fetch students: ${response.error!.message}', Colors.red);
    return;
  }

  List<Map<String, dynamic>> studentLists = List<Map<String, dynamic>>.from(response.data);

  studentList.value = studentLists;
}
Future<void> getCourse() async {
  //  await Supabase.initialize(
  //   url: supBaseUrl,
  //   anonKey: supBaseKey
  // );
  final response = await Supabase.instance.client
      .from('Course') 
      .select() 
      .execute(); 

  if (response.error != null) {
    showCustomSnackbar('Error', 'Failed to fetch courses: ${response.error!.message}', Colors.red);
    return;
  }

  List<Map<String, dynamic>> courseLists = List<Map<String, dynamic>>.from(response.data);

  courseList.value = courseLists;
}
  Future<void> deleteStudent(int id) async {
  // await Supabase.initialize(
  //   url: supBaseUrl,
  //   anonKey: supBaseKey
  // );
  final response = await Supabase.instance.client
      .from('Student') 
      .delete() 
      .eq('id', id) 
      .execute(); 

  
  if (response.error != null) {
    showCustomSnackbar('Error', 'Failed to delete student: ${response.error!.message}', Colors.red);
    return;
  }

  showCustomSnackbar('Congratulation', 'Successfully Deleted', appMainColor);

  final studentResponse = await Supabase.instance.client
      .from('Student') 
      .select() 
      .execute(); 

  if (studentResponse.error != null) {
    showCustomSnackbar('Error', 'Failed to fetch students: ${studentResponse.error!.message}', Colors.red);
    return;
  }

  List<Map<String, dynamic>> studentLists = List<Map<String, dynamic>>.from(studentResponse.data);

  studentList.value = studentLists;
}
}