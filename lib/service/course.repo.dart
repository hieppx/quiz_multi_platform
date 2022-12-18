import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_multi_platform/common/url.dart';

import '../models/course.dart';


class CourseRepo {
  Future<List<Course>> getCourse() async {
    var url = Uri.parse(Url.getCourse);
   var res = await http.post(url);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.map((e) => Course.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }
}
