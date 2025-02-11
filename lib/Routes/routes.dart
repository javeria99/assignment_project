import 'package:assigment_project/Screens/add_student_screen.dart';
import 'package:assigment_project/Screens/dashboard_screen.dart';
import 'package:assigment_project/Screens/login_screen.dart';
import 'package:assigment_project/Screens/sign_up_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage<dynamic>> getPages = [
GetPage(name: '/loginPage', page: ()=> const LoginScreen()),
GetPage(name: '/signUpPage', page: ()=> const SignUpScreen()),
GetPage(name: '/addStudentPage', page: ()=> const AddStudentScreen()),
GetPage(name: '/dashBoardPage', page: ()=> const DashBoardScreen()),
];