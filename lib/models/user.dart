class User {
  int? id;
  String? userName;
  String? password;
  String? fullName;
  String? bod;
  String? gender;
  String? address;
  String? phone;
  String? questionSecurity;

  User(
      {this.id,
      this.userName,
      this.password,
      this.fullName,
      this.bod,
      this.gender,
      this.address,
      this.phone,
      this.questionSecurity});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse(json['ID']),
      userName: json['username'],
      password: json['password'],
      fullName: json['full_name'],
      bod: json['bod'],
      gender: json['gender'],
      address: json['address'],
      phone: json['phone'],
      questionSecurity: json['question_security'],
    );
  }
}
