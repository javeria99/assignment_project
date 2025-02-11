
import 'package:assigment_project/Constant/color.dart';
import 'package:assigment_project/Widget/snack._bar.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DashboardController extends GetxController {
    var studentList = <Map>[].obs;
    RxMap<dynamic, dynamic> student = <String, dynamic>{}.obs;
    var courseList = <Map>[].obs;
  Future<void> getStudent() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'student.db');
    Database database = await openDatabase(path);
    List<Map> result = await database.rawQuery('SELECT * FROM Student');
    await database.close();
    studentList.value = result;
  }
Future<void> getCourse() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'student.db');
    Database database = await openDatabase(path);
    courseList.value = await database.rawQuery('SELECT * FROM Course');
    await database.close();
  }
  Future<void> deleteStudent(int id) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'student.db');
    Database database = await openDatabase(path);
    courseList.value = await database.rawQuery('DELETE FROM student WHERE id = ?', [id]);
    showCustomSnackbar(
            'Congratulation', 'Successfully Deleted', appMainColor);
    List<Map> result = await database.rawQuery('SELECT * FROM Student');
    studentList.value = result;
    await database.close();
  }
}