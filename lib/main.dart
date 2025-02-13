import 'package:assigment_project/Constant/constant.dart';
import 'package:assigment_project/Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var databasesPath = await getDatabasesPath();
  // String path = join(databasesPath, 'student.db');
  // //await deleteDatabase(path);
  // Database database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
  //   await db.execute('PRAGMA foreign_keys = ON;');
  //   await db.execute(
  //     'CREATE TABLE User (id INTEGER PRIMARY KEY, name TEXT, password TEXT);'
  //   );
  //   await db.execute(
  //     'CREATE TABLE Student (id INTEGER PRIMARY KEY, name TEXT, class INTEGER, section TEXT);'
  //   );
  //   await db.execute(
  //     'CREATE TABLE Course (id INTEGER PRIMARY KEY, name TEXT);'
  //   );
  //   await db.execute(
  //     'CREATE TABLE Enrollment (id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, '
  //     'FOREIGN KEY(student_id) REFERENCES Student(id) ON DELETE CASCADE, '
  //     'FOREIGN KEY(course_id) REFERENCES Course(id) ON DELETE CASCADE);'
  //   );
  //   await db.rawInsert('INSERT INTO Course(name) VALUES("Urdu")');
  //   await db.rawInsert('INSERT INTO Course(name) VALUES("English")');
  //   await db.rawInsert('INSERT INTO Course(name) VALUES("Math")');
  //   await db.rawInsert('INSERT INTO Course(name) VALUES("Science")');
  // });

  // await database.close();
  await Supabase.initialize(
    url: supBaseUrl,
    anonKey: supBaseKey,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      builder: BotToastInit(),
      //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      getPages: getPages,
      title: 'Simple student app',
      home: const SplashScreen(),
    );
  }
}
