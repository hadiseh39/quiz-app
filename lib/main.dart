import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/screens/home_screen.dart';

import 'controller/question_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(QuestionController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: HomeScreen(),
    );
  }
}
