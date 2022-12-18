import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/course.dart';
import '../../../service/course.repo.dart';

class CourseModel extends ChangeNotifier {
  CourseRepo courseRepo = CourseRepo();

  List<Course> _course = [];
  List<Course> get course => _course;

  final List<Course> _courseTmp = [];

  final TextEditingController _searchCourse = TextEditingController();
  TextEditingController get searchCourse => _searchCourse;

  void getCourse() async {
    List<Course> tmp = [];
    List<String> titleCourse = [];
    tmp = await courseRepo.getCourse();
    for (var i = 0; i < tmp.length; i++) {
      var item = tmp[i];
      _courseTmp.add(item);
      titleCourse.add(item.title ?? '');
    }
    _course = _courseTmp;
    getListCourse(titleCourse);
    notifyListeners();
  }

  void onSearch(String value) {
    _course = _courseTmp
        .where((element) =>
            element.title!.toUpperCase().contains(value.toUpperCase()))
        .toList();
    notifyListeners();
  }

  Future<void> getListCourse(List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('listTitle', list);
    notifyListeners();
  }

  Future<void> getParamCourse(String title, String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('title', title);
    await prefs.setString('courseID', id);
    notifyListeners();
  }
}
