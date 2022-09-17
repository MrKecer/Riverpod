import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student/models/students/students.dart';
import 'package:http/http.dart' as http;

class DataService {
  int i = 1;
  final String url = "https://6321b51dfd698dfa29fd3371.mockapi.io/Students";
  Future<Students> studentDownload() async {
    final http.Response response = await http.get(Uri.parse("$url/$i"));

    return Students.fromJson(jsonDecode(response.body));
  }

  Future<void> studentAdd(Students n) async {
    final response = await http.post(
      Uri.parse("$url/"),
      headers: <String, String>{
        "Content-Type": "application/jspn; charset=UTF-8",
      },
      body: jsonEncode(n.fromMap()),
    );
    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to add student.');
    }
  }
}

final dataServiceProvider = Provider((ref) {
  return DataService();
});
