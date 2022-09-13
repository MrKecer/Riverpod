import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student/Screens/messages/messsages.dart';
import 'package:student/Screens/studentsScreen/student.dart';

import 'package:student/models/messages/message.dart';
import 'package:student/models/studentsRepo/studentsRepo.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsRepo = ref.watch(studentProvider);
    final messageRepo = ref.watch(messageRef);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Öğrenci Uygulaması"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: TextButton(
                    onPressed: () {
                      studentButton(context);
                    },
                    child: const Text("Öğrenciler"),
                  ),
                ),
              ],
            ),
            Card(
              child: TextButton(
                onPressed: (() {
                  messagesButton(context);
                }),
                child: Text(
                    "Mesajlar (${messageRepo.getMessageCount} yeni mesaj)"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void studentButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentsList(),
      ),
    );
  }

  messagesButton(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Messages();
        },
      ),
    );
  }
}
