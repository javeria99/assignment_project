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