import 'package:flutter/material.dart';

import '../../../models/rank.dart';
import '../../../service/rank.repo.dart';

class RankModel extends ChangeNotifier {
  RankRepo rankRepo = RankRepo();

  List<Rank> _rank = [];
  List<Rank> get rank => _rank;

  void getRank(String title) async {
    _rank = [];
    List<Rank> tmp = [];
    tmp = await rankRepo.getRank(title);
    for (var i = 0; i < tmp.length; i++) {
      var item = tmp[i];
      _rank.add(item);
    }
    _rank.sort((a, b) => b.score!.compareTo(a.score!));
    notifyListeners();
  }
}
