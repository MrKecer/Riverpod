import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student/service/service.dart';

import '../../models/studentsRepo/students.dart';

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

    notifyListeners();
  }

  bool doILove(Students students) {
    return iLove.contains(students);
  }

  void download() async {
    Students students = await dataService.studentDownload();

    student.add(students);
    notifyListeners();
  }

  final DataService dataService;
  StudentsRepo(this.dataService);
}

final studentProvider = ChangeNotifierProvider((ref) {
  return StudentsRepo(ref.watch(dataServiceProvider));
});
