class QuestionForm {
  late String questiontext;
  late bool answertext;

  QuestionForm({required String q, required bool a}) {
    questiontext = q;
    answertext = a;
  }
}

class QuestionBank {
  int questionNo = 0;
  List<QuestionForm> question = [
    QuestionForm(q: '2+2 = 4', a: true),
    QuestionForm(q: '2+3 = 4', a: false),
    QuestionForm(q: '2+6 = 8', a: true),
  ];

  void nextQuestion() {
    if (questionNo < question.length - 1) {
      questionNo++; //2
    }
  }

  String getQuestion() {
    return question[questionNo].questiontext;
  }

  bool getAnswer() {
    return question[questionNo].answertext;
  }

  bool isFinished() {
    if (questionNo == question.length - 1)
      return true;
    else
      return false;
  }
}
