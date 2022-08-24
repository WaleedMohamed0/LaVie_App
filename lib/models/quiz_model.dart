class QuizModel {
  String question = "";
  List<String> questionAnswers = [];
  int answerChosen = -1;
  int correctAnswer = -1;
  bool answered;
  // List<String>? imgUrl =  List.filled(9, "assets/images/UnSelectedAnswer.png");

  QuizModel(
      {required this.question,
      required this.questionAnswers,
      required this.correctAnswer,
      this.answerChosen = -1,
      this.answered= false});
}
