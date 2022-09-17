import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/messageRepo/messageRepository.dart';

class Messages extends ConsumerStatefulWidget {
  const Messages({super.key});

  @override
  ConsumerState<Messages> createState() => _MessagesState();
}

class _MessagesState extends ConsumerState<Messages> {
  bool reverse = true;
  @override
  void initState() {
    Future.delayed(Duration.zero).whenComplete(() {
      ref.read(messageRef).setMessageCount = 0;
    });

    super.initState();
  }

  String? sendMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: (() {
                  ref.refresh(messageRef);
                }),
                icon: const Icon(Icons.clear_all))
          ],
          centerTitle: true,
          title: const Text("Mesajlar"),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.builder(
                reverse: reverse,
                itemCount: ref.watch(messageRef).m.length,
                itemBuilder: (context, index) {
                  bool? me = Random().nextBool();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: me == true
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          // border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Column(
                            children: [
                              Text(
                                "${ref.watch(messageRef).m[index].text}\n"
                                "${ref.watch(messageRef).m[index].time!.hour}"
                                ":"
                                "${ref.watch(messageRef).m[index].time!.minute}",
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextField(
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            onChanged: (value) {
                              sendMessage = value;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        reverse = false;
                        sendMessage != null
                            ? ref.watch(messageRef).sendMessage(sendMessage!)
                            : null;
                      },
                      child: const Text("Gönder")),
                  const SizedBox(
                    width: 8,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
