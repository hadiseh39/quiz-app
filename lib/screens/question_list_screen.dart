import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/question_controller.dart';

class QuestionListPage extends StatelessWidget {
  final qController = Get.find<QuestionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('لیست سوالات')),
      body: Obx(() {
        if (qController.questions.isEmpty) {
          return Center(child: Text('سوالی وجود ندارد.'));
        }

        return ListView.builder(
          itemCount: qController.questions.length,
          itemBuilder: (context, index) {
            final question = qController.questions[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ExpansionTile(
                title: Text(question.question),
                subtitle: Row(
                  children: [
                    Text(
                      question.isLearned ? 'یادگرفته شده' : 'یادنگرفته',
                      style: TextStyle(
                        color: question.isLearned ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
                children: [
                  ...List.generate(
                    question.options.length,
                    (i) => ListTile(
                      title: Text(question.options[i]),
                      leading: Icon(
                        question.options[i] == question.correctAnswer
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: question.options[i] == question.correctAnswer
                            ? Colors.green
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text('یادگرفته شده'),
                        Switch(
                          value: question.isLearned,
                          onChanged: (val) {
                            qController.markAsLearned(question.id!, val);
                          },
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await qController.deleteQuestion(question.id!);
                            Get.snackbar('حذف شد', 'سوال حذف شد');
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
