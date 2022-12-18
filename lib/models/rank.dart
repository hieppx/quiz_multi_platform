class Rank {
  String? id;
  String? title;
  String? userName;
  String? fullName;
  int? score;

  Rank({
    this.id,
    this.title,
    this.userName,
    this.fullName,
    this.score
  });

  factory Rank.fromJson(Map<String, dynamic> json) {
    return Rank(
      id: json['ID'],
      title: json['title'],
      userName: json['username'],
      fullName: json['full_name'],
      score: int.parse(json['score'])
    );
  }
}
