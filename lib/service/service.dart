import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student/models/studentsRepo/students.dart';
import 'package:http/http.dart' as http;

class DataService {
  int i = 1;
  final String url = "https://6321b51dfd698dfa29fd3371.mockapi.io/Students";
  Future<Students> studentDownload() async {
    final http.Response response = await http.get(Uri.parse("$url/$i"));

    return Students.fromJson(jsonDecode(response.body));
  }
}

final dataServiceProvider = Provider((ref) {
  return DataService();
});
