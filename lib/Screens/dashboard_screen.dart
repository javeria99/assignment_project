import 'package:assigment_project/Constant/color.dart';
import 'package:assigment_project/Constant/constant.dart';
import 'package:assigment_project/Widget/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    dashboardController.getStudent();
    dashboardController.getCourse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 1, 55, 99),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  'Welcome to dashboard',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: appMainColor),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(buttonText: '+', onTap: () {
                    addEditController.isEdit.value=false;
                    Get.toNamed('/addStudentPage');}),
                  Button(
                      buttonText: 'Log out',
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('didLogin', false);
                        Get.offNamedUntil('/loginPage', (route) => false);
                      }),
                ],
              ),
              Obx(() {
                if (dashboardController.studentList.isEmpty) {
                  return Center(child: Text('No data found',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: appMainColor),));
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: dashboardController.studentList.length,
                    itemBuilder: (context, index) {
                      var student = dashboardController.studentList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                        Flexible(child: Text(student['name'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: appMainColor),)),
                        Flexible(child: Text(student['class'].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: appMainColor),)),
                        Flexible(child: Text(student['section'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: appMainColor),)),
                        IconButton(onPressed: (){
                          dashboardController.student.value=student;
                          addEditController.isEdit.value=true;
                          Get.toNamed('/addStudentPage');
                        }, icon: const Icon(Icons.edit,color: Colors.white,)),
                        IconButton(onPressed: (){
                          dashboardController.deleteStudent(student['id']);
                        }, icon: const Icon(Icons.delete,color: Colors.red,)),
            ]),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ));
  }
}
