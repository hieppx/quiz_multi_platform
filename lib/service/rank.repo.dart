import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_multi_platform/common/url.dart';
import '../models/rank.dart';

class RankRepo {
  Future<List<Rank>> getRank(String title) async {
    var url = Uri.parse(Url.getRank);
    var res = await http.post(url, body: {"title": title});
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.map((e) => Rank.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }

  Future<void> insertRank(String userID, String courseID, String score) async {
    var url = Uri.parse(Url.insertRank);
    await http.post(url, body: {
      'userID': userID,
      'courseID': courseID,
      'score': score,
    });
  }
}
