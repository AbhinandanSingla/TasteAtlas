class tagModel {
  final String id;
  final List tag;
  int priority;
  final String name;
  final String url;
  final String rating;
  bool isFirstTime;
final int price;
  tagModel( {this.price,
    this.id,
    this.tag,
    this.priority,
    this.name,
    this.url,
    this.rating,
    this.isFirstTime
  });
}

class QuestionModel {
  final List answers;
  final String question;

  QuestionModel({
    this.question,
    this.answers,
  });
}

class AnswerModel {
  final String tag;
  final String answer;

  AnswerModel({this.tag, this.answer});
}
