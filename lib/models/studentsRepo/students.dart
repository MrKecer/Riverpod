class Students {
  String? name;
  String? surname;
  int? age;
  String? gender;

  Students(this.name, this.surname, this.age, this.gender);
  Students.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    surname = json["surname"];
    age = json["age"];
    gender = json["gender"];
  }
}
