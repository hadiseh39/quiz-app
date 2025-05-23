import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/question_controller.dart';
import 'package:quiz_app/model/question.dart';

class AddQuestionPage extends StatefulWidget {
  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final questionController = TextEditingController();
  final optionControllers = List.generate(4, (_) => TextEditingController());
  int correctIndex = 0;

  final qController = Get.find<QuestionController>();

  void saveQuestion() {
    final questionText = questionController.text.trim();
    final options = optionControllers.map((e) => e.text.trim()).toList();

    if (questionText.isEmpty || options.any((o) => o.isEmpty)) {
      Get.snackbar("خطا", "لطفاً تمام فیلدها را پر کنید");
      return;
    }

    final newQuestion = Question(
      id: null,
      question: questionText,
      options: options,
      correctAnswer: options[correctIndex],
    );

    qController.addQuestion(newQuestion);
    Get.snackbar("موفقیت", "سوال با موفقیت اضافه شد");
    questionController.clear();
    optionControllers.forEach((c) => c.clear());
    setState(() => correctIndex = 0);
  }

  @override
  void dispose() {
    questionController.dispose();
    optionControllers.forEach((c) => c.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('افزودن سوال')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: questionController,
              decoration: InputDecoration(labelText: 'متن سوال'),
            ),
            SizedBox(height: 16),
            ...List.generate(4, (index) {
              return ListTile(
                title: TextField(
                  controller: optionControllers[index],
                  decoration: InputDecoration(labelText: 'گزینه ${index + 1}'),
                ),
                leading: Radio(
                  value: index,
                  groupValue: correctIndex,
                  onChanged: (val) {
                    setState(() {
                      correctIndex = val as int;
                    });
                  },
                ),
              );
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveQuestion,
              child: Text('ذخیره سوال'),
            )
          ],
        ),
      ),
    );
  }
}
