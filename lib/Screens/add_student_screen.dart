import 'package:assigment_project/Constant/color.dart';
import 'package:assigment_project/Constant/constant.dart';
import 'package:assigment_project/Widget/button.dart';
import 'package:assigment_project/Widget/snack._bar.dart';
import 'package:assigment_project/Widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  @override
  void initState(){
    setState(() {
      addEditController.nameController.text="";
      addEditController.classController.text="";
      addEditController.sectionController.text="";
      addEditController.selectedCourseIds.clear();
      if(addEditController.isEdit.value==true){
        addEditController.nameController.text=dashboardController.student['name'];
        addEditController.classController.text=dashboardController.student['class'].toString();
        addEditController.sectionController.text=dashboardController.student['section'];
        getEnrollCourse();
      }
    });
    super.initState();
  }
  
    Future<void> getEnrollCourse() async {
  await Supabase.initialize(
    url: supBaseUrl,
    anonKey: supBaseKey
  );
  final client = Supabase.instance.client;

  final response = await client
      .from('Enrollment') 
      .select() 
      .eq('student_id', dashboardController.student['id']) 
      .execute(); 

  if (response.error != null) {
    showCustomSnackbar('Error', 'Failed to fetch enrollment courses: ${response.error!.message}', Colors.red);
    return;
  }

  List<Map<String, dynamic>> enrollments = List<Map<String, dynamic>>.from(response.data);

  for (var check in enrollments) {
    addEditController.selectedCourseIds.add(check['course_id']);
  }

  setState(() {
    addEditController.selectedCourseIds;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 1, 55, 99),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  'Add student',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: appMainColor),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedTextField(
                    circularRadius: 10,
                    controller: addEditController.nameController,
                    borderColor: appMainColor,
                    textColor: appMainColor,
                    readOnly: false,
                    cursorColor: appMainColor,
                    keyBoardType: TextInputType.name,
                    hintText: 'Student name',
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
                    controller: addEditController.classController,
                    borderColor: appMainColor,
                    textColor: appMainColor,
                    readOnly: false,
                    cursorColor: appMainColor,
                    keyBoardType: TextInputType.number,
                    hintText: 'Class',
                    hintColor: appMainColor,
                    prefixIcon: const Icon(Icons.school),
                    prefixIconColor: appMainColor,
                    obscureText: false,
                    horizontalPadding: 20,
                    backgroundColor: Colors.white24,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RoundedTextField(
                    circularRadius: 10,
                    controller: addEditController.sectionController,
                    borderColor: appMainColor,
                    textColor: appMainColor,
                    readOnly: false,
                    cursorColor: appMainColor,
                    keyBoardType: TextInputType.name,
                    hintText: 'Section',
                    hintColor: appMainColor,
                    prefixIcon: const Icon(Icons.school),
                    prefixIconColor: appMainColor,
                    obscureText: false,
                    horizontalPadding: 20,
                    backgroundColor: Colors.white24,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(() {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: dashboardController.courseList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(dashboardController.courseList[index]['name'],style: TextStyle(color: appMainColor),),
                          trailing: Checkbox(
                            value: addEditController.isSelected(dashboardController.courseList[index]['id']),
                            onChanged: (bool? value) {
                              addEditController.courseSelection(dashboardController.courseList[index]['id']);
                             setState(() {
                              });
                            },
                          ),
                        );
                      },
                    );
                  }),
                  const SizedBox(
                    height: 30,
                  ),
                  Button(
                      buttonText: 'Add student',
                      onTap: () {
                        bool validation =
                            addEditController.validationStudent(context);
                        if (validation == true) {
                          addEditController.addStudent();
                          dashboardController.getStudent();
                          Get.back();
                        }
                      }),
                ],
              )
            ],
          ),
        ));
  }
}
