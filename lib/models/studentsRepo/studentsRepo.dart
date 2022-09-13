import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentsRepo extends ChangeNotifier {
  List<Students> student = [
    Students("Yusuf", "Keçer", 23, "Erkek"),
    Students("Yusuwqef", "Kesdfçer", 233, "Kadın"),
    Students("Yusasduf", "Keçeasdr", 23, "Erkek"),
    Students("Yuadfsuf", "Kadeçer", 232, "dsfsdf"),
  ];

  final List<Students> iLove = [];

  void love(student, bool isThere) {
    isThere == false ? iLove.add(student) : iLove.remove(student);
    print(isThere);
    notifyListeners();
  }

  bool doILove(Students students) {
    return iLove.contains(students);
  }

  @override
  String toString() => 'StudentsRepo(student: $student, iLove: $iLove)';
}

final studentProvider = ChangeNotifierProvider((ref) {
  return StudentsRepo();
});

class Students {
  String? name;
  String? surname;
  int? ago;
  String? gender;

  Students(this.name, this.surname, this.ago, this.gender);
}
