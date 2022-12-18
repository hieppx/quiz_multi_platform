import 'package:flutter/material.dart';
import 'package:quiz_multi_platform/service/rank.repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/questions.dart';
import '../../../service/question.repo.dart';
import '../widget/score.dart';

class QuizModel extends ChangeNotifier {
  QuestionRepo questionRepo = QuestionRepo();

  RankRepo rankRepo = RankRepo();

  final List<Question> _question = [];
  List<Question> get question => _question;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  int? _correctAns;
  int? get correctAns => _correctAns;

  int? _selectedAns;
  int? get selectedAns => _selectedAns;

  int _questionNumber = 1;
  int get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  PageController _pageController = PageController(initialPage: 0);
  PageController get pageController => _pageController;

  int? _pageChanged = 0;
  int? get pageChanged => _pageChanged;

  AnimationController? _animationController;
  AnimationController? get animationController => _animationController;

  Animation? _animation;
  Animation? get animation => _animation;

  void getPage(int value) {
    _pageChanged = value;
    _questionNumber = value + 1;
    notifyListeners();
  }

  void getTime(TickerProvider ticket) {
    _animationController = AnimationController(
        duration: const Duration(seconds: 12), vsync: ticket);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
      ..addListener(() {
        notifyListeners();
      });
    _animationController!.forward().whenComplete(() => nextPage);
    _pageController = PageController();
    notifyListeners();
  }

  void nextPage(BuildContext context) async {
    if (_questionNumber != _question.length) {
      _isAnswered = false;
      _pageController.animateToPage(_pageChanged! + 1,
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
      _animationController!.reset();
      _animationController!.forward().whenComplete(() => nextPage);
    } else {
      _animationController!.stop();
      insertResult(_numOfCorrectAns);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ScoreScreen(
                    correctAns: _numOfCorrectAns,
                    allAns: _question.length,
                  )));
    }
    notifyListeners();
  }

  String? courseID;

  void getQuestion() async {
    final prefs = await SharedPreferences.getInstance();
    courseID = prefs.getString('courseID');
    List<Question> tmp = [];
    tmp = await questionRepo.getQuestion(courseID!);
    for (var i = 0; i < tmp.length; i++) {
      var item = tmp[i];
      _question.add(item);
    }
    notifyListeners();
  }

  void checkAns(Question qs, int selectedIndex, BuildContext context) {
    _isAnswered = true;
    _correctAns = qs.answerIndex;
    _selectedAns = selectedIndex;
    if (_correctAns == _selectedAns) _numOfCorrectAns++;
    _animationController!.stop();
    Future.delayed(const Duration(seconds: 2), () {
      nextPage(context);
    });
    notifyListeners();
  }

  void insertResult(int score) async {
    final prefs = await SharedPreferences.getInstance();
    int? userID = prefs.getInt('userID');
    await rankRepo.insertRank(userID.toString(), courseID!, score.toString());
    notifyListeners();
  }
}
