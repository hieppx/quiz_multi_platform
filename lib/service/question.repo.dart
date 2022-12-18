import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_multi_platform/common/url.dart';

import '../models/questions.dart';


class QuestionRepo {
  Future<List<Question>> getQuestion(String courseID) async {
    var url =
        Uri.parse(Url.getQuestion);
    var res = await http.post(url, body: {
      "courseID": courseID,
    });
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.map((e) => Question.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }
}
