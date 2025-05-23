import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/question_controller.dart';
import '../model/question.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final qController = Get.find<QuestionController>();
  late List<Question> quizQuestions;
  int currentIndex = 0;
  int? selectedIndex;
  bool showAnswer = false;
  int correctAnswers = 0;

  List<String> shuffledOptions = [];

  @override
  void initState() {
    super.initState();
    quizQuestions = qController.getRandomUnlearnedQuestions(10);
    _shuffleOptions();
  }

  void _shuffleOptions() {
    if (quizQuestions.isEmpty) return;
    shuffledOptions = List.from(quizQuestions[currentIndex].options)..shuffle();
  }

  void _nextQuestion() {
    setState(() {
      if (!showAnswer) {
        // check answer
        final currentQuestion = quizQuestions[currentIndex];
        final selectedAnswer = shuffledOptions[selectedIndex ?? -1];
        if (selectedAnswer == currentQuestion.correctAnswer) {
          correctAnswers++;
        }

        showAnswer = true;
      } else {
        // next question
        if (currentIndex < quizQuestions.length - 1) {
          currentIndex++;
          selectedIndex = null;
          showAnswer = false;
          _shuffleOptions();
        } else {
          Get.defaultDialog(
            title: 'پایان آزمون',
            middleText:
                'آزمون تمام شد!\nتعداد پاسخ‌های صحیح: $correctAnswers از ${quizQuestions.length}',
            confirm: ElevatedButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: Text('بازگشت'),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (quizQuestions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('آزمون')),
        body: Center(child: Text('هیچ سوالی برای آزمون وجود ندارد')),
      );
    }

    final question = quizQuestions[currentIndex];
    final correctIndex = shuffledOptions.indexOf(question.correctAnswer);

    return Scaffold(
      appBar: AppBar(title: Text('آزمون')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('سوال ${currentIndex + 1} از ${quizQuestions.length}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text(question.question,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            ...List.generate(shuffledOptions.length, (index) {
              final option = shuffledOptions[index];
              Color? color;

              if (showAnswer) {
                if (index == correctIndex) {
                  color = Colors.green;
                } else if (selectedIndex == index) {
                  color = Colors.red;
                } else {
                  color = const Color.fromARGB(255, 46, 46, 46);
                }
              } else {
                color = selectedIndex == index
                    ? Colors.blueAccent.withOpacity(0.6)
                    : const Color.fromARGB(255, 46, 46, 46);
              }

              return GestureDetector(
                onTap: showAnswer
                    ? null
                    : () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black26),
                  ),
                  child: Text(
                    option,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              );
            }),
            Spacer(),
            ElevatedButton(
              onPressed:
                  selectedIndex == null && !showAnswer ? null : _nextQuestion,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(showAnswer ? 'سوال بعد' : 'بررسی پاسخ'),
            ),
          ],
        ),
      ),
    );
  }
}
