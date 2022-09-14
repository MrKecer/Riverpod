import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student/service/service.dart';

import '../../data/studentRepo/studentRepository.dart';

class StudentsList extends ConsumerWidget {
  const StudentsList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          DownloadButton(),
        ],
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
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_border_outlined)),
              );
            },
          ))
        ],
      ),
    );
  }
}

class DownloadButton extends ConsumerStatefulWidget {
  const DownloadButton({super.key});

  @override
  ConsumerState<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends ConsumerState<DownloadButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Transform.scale(
            scale: 0.5,
            child: const CircularProgressIndicator(
              color: Colors.red,
            ),
          )
        : IconButton(
            onPressed: () async {
              setState(() {
                loading = true;
              });

              await ref.read(studentProvider).download();
              ref.watch(dataServiceProvider).i =
                  ref.watch(dataServiceProvider).i + 1;

              setState(() {
                loading = false;
              });
            },
            icon: const Icon(Icons.download_for_offline_outlined));
  }
}
