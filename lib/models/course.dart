class Course {
  String? id;
  String? title;
  
  Course({
    this.id,
    this.title,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['ID'],
      title: json['title'],
    );
  }
}
