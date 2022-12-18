class Question {
  int? id;
  String? content;
  int? courseID;
  int? answerIndex;
  List<String>? options;

  Question(
      {this.id, this.content, this.options, this.courseID, this.answerIndex});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        id: int.parse(json['ID']),
        content: json['content'],
        courseID: int.parse(json['courseID']),
        options: [
          json['answer_a'],
          json['answer_b'],
          json['answer_c'],
          json['answer_d']
        ],
        answerIndex: int.parse(json['answer_index']));
  }
}


