import 'package:get/get.dart';
import 'package:quiz_app/model/question.dart';
import '../services/question_db.dart';

class QuestionController extends GetxController {
  RxList<Question> questions = <Question>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    questions.value = await QuestionDB().getAllQuestions();
  }

  Future<void> addQuestion(Question question) async {
    await QuestionDB().insertQuestion(question);
    loadQuestions();
  }

  Future<void> markAsLearned(int id, bool value) async {
    await QuestionDB().updateIsLearned(id, value);
    loadQuestions();
  }

  Future<void> deleteQuestion(int id) async {
    await QuestionDB().deleteQuestion(id);
    loadQuestions();
  }

  List<Question> getRandomUnlearnedQuestions([int count = 10]) {
    final unlearned = questions.where((q) => !q.isLearned).toList();
    unlearned.shuffle();
    return unlearned.take(count).toList();
  }
}
