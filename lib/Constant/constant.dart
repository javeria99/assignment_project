import 'package:assigment_project/Controller/add_edit_controller.dart';
import 'package:assigment_project/Controller/dashboard_controller.dart';
import 'package:assigment_project/Controller/login_controller.dart';
import 'package:assigment_project/Controller/sign_up_controller.dart';
import 'package:get/get.dart';

bool didLogin=false;
final LoginController loginController=Get.put(LoginController());
final SignUpController signUpController=Get.put(SignUpController());
final DashboardController dashboardController=Get.put(DashboardController());
final AddEditController addEditController=Get.put(AddEditController());
String supBaseUrl="https://fdtssbnndygjszxgriux.supabase.co";
String supBaseKey="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZkdHNzYm5uZHlnanN6eGdyaXV4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk0MzE3OTUsImV4cCI6MjA1NTAwNzc5NX0.nxB0YTTZBURm6rEo-SvJo-TjT7VJgiUdY9qYM8JDMpQ";