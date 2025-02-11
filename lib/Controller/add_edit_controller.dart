import 'package:assigment_project/Constant/color.dart';
import 'package:assigment_project/Constant/constant.dart';
import 'package:assigment_project/Widget/snack._bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AddEditController extends GetxController {
  RxBool isEdit=false.obs;
  TextEditingController classController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  RxList selectedCourseIds = [].obs;

  void courseSelection(int courseId) {
    if (selectedCourseIds.contains(courseId)) {
      selectedCourseIds.remove(courseId);
    } else {
      selectedCourseIds.add(courseId);
    }
  }

  bool isSelected(int courseId) {
    return selectedCourseIds.contains(courseId);
  }
  bool validationStudent(context) {
    if (nameController.text.isEmpty) {
      showCustomSnackbar('Warning', 'Kindly enter student name', Colors.red);
      return false;
    } else if (classController.text.isEmpty) {
      showCustomSnackbar('Warning', 'Kindly enter student class', Colors.red);
      return false;
    } else if (sectionController.text.isEmpty) {
      showCustomSnackbar('Warning', 'Kindly enter student section', Colors.red);
      return false;
    }
    return true;
  }
  Future<void> addStudent() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'student.db');
    Database database = await openDatabase(path, version: 1);
        if(isEdit.value==false){
       int studentId= await database.rawInsert(
            'INSERT INTO Student(name, class, section) VALUES("${nameController.text}", ${int.parse(classController.text)}, "${sectionController.text}")');
        if (selectedCourseIds.isNotEmpty){
          for(var id in selectedCourseIds){
            await database.rawInsert(
            'INSERT INTO Enrollment(student_id, course_id ) VALUES($studentId, $id )');
          }
        }
        showCustomSnackbar(
            'Congratulation', 'Successfully Added', appMainColor);
        }
        else{
        await database.rawUpdate(
    'UPDATE Student SET name = ?, class = ?, section = ? WHERE id = ?',
    [addEditController.nameController.text, int.parse(addEditController.classController.text,), addEditController.sectionController.text, dashboardController.student['id']]);
          showCustomSnackbar(
            'Congratulation', 'Successfully Edited', appMainColor);
        }
    await database.close();
  }
}