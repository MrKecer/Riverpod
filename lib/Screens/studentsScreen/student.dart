import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student/models/studentsRepo/studentsRepo.dart';

class StudentsList extends ConsumerWidget {
  StudentsList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Öğrenci Mobil Uygulaması"),
      ),
      body: Column(
        children: [
          const Text("Öğrenciler"),
          Expanded(
              child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: ref.watch(studentProvider).student.length,
            itemBuilder: (context, index) {
              bool isThere = ref
                  .watch(studentProvider)
                  .doILove(ref.watch(studentProvider).student[index]);
              return ListTile(
                leading:
                    ref.watch(studentProvider).student[index].gender == "Kadın"
                        ? const Text("👩")
                        : const Text("👨"),
                title: Text(
                    "${ref.watch(studentProvider).student[index].name} ${ref.watch(studentProvider).student[index].surname}"),
                trailing: IconButton(
                    onPressed: () {
                      ref.watch(studentProvider).love(
                          ref.watch(studentProvider).student[index], isThere);
                    },
                    icon: ref
                            .watch(studentProvider)
                            .doILove(ref.watch(studentProvider).student[index])
                        ? const Icon(Icons.abc)
                        : const Icon(Icons.favorite)),
              );
            },
          ))
        ],
      ),
    );
  }
}
