class Question {
  final int? id;
  final String question;
  final List<String> options;
  final String correctAnswer;
  bool isLearned;

  Question({
    this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.isLearned = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'option1': options[0],
      'option2': options[1],
      'option3': options[2],
      'option4': options[3],
      'correctAnswer': correctAnswer,
      'isLearned': isLearned ? 1 : 0,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      question: map['question'],
      options: [
        map['option1'],
        map['option2'],
        map['option3'],
        map['option4'],
      ],
      correctAnswer: map['correctAnswer'],
      isLearned: map['isLearned'] == 1,
    );
  }
}
