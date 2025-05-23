import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/screens/question_list_screen.dart';
import 'package:quiz_app/widgets/home_button.dart';

import 'add_question_screen.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اپلیکیشن آزمون‌ساز'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeButton(
                title: '➕ افزودن سوال',
                onTap: () => Get.to(() => AddQuestionPage()),
              ),
              SizedBox(height: 16),
              HomeButton(
                title: '📋 لیست سوالات',
                onTap: () => Get.to(() => QuestionListPage()),
              ),
              SizedBox(height: 16),
              HomeButton(
                title: '🧠 شروع آزمون',
                onTap: () => Get.to(() => QuizPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
