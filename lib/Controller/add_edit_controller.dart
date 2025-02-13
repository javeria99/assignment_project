import 'package:assigment_project/Constant/color.dart';
import 'package:assigment_project/Constant/constant.dart';
import 'package:assigment_project/Widget/snack._bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    await Supabase.initialize(
    url: supBaseUrl,
    anonKey: supBaseKey
  );
  final client = Supabase.instance.client;

  if (!isEdit.value) {
    final response = await client.from('Student').insert({
      'name': nameController.text,
      'class': int.parse(classController.text),
      'section': sectionController.text,
    }).execute();

    if (response.error != null) {
      showCustomSnackbar('Error', 'Failed to add student: ${response.error!.message}', Colors.red);
      return;
    }

    int studentId = response.data[0]['id'];

    if (selectedCourseIds.isNotEmpty) {
      for (var id in selectedCourseIds) {
        final enrollmentResponse = await client.from('Enrollment').insert({
          'student_id': studentId,
          'course_id': id,
        }).execute();

        if (enrollmentResponse.error != null) {
          showCustomSnackbar('Error', 'Failed to enroll student in course: ${enrollmentResponse.error!.message}', Colors.red);
          return;
        }
      }
    }

    showCustomSnackbar('Congratulation', 'Successfully Added', appMainColor);

  } else {
    final updateResponse = await client.from('Student').update({
      'name': addEditController.nameController.text,
      'class': int.parse(addEditController.classController.text),
      'section': addEditController.sectionController.text,
    }).eq('id', dashboardController.student['id']).execute();

    if (updateResponse.error != null) {
      showCustomSnackbar('Error', 'Failed to update student: ${updateResponse.error!.message}', Colors.red);
      return;
    }

    showCustomSnackbar('Congratulation', 'Successfully Edited', appMainColor);
  }
}
}