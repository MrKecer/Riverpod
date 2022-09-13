import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student/models/messages/message.dart';

class Messages extends ConsumerStatefulWidget {
  const Messages({super.key});

  @override
  ConsumerState<Messages> createState() => _MessagesState();
}

class _MessagesState extends ConsumerState<Messages> {
  List messages = [
    "safasdfasdf",
    "asdfasdfdaf",
    "sdfsgdfgsadf",
    "sadfsgasdgasgd",
    "sadfasasdfasd",
  ];
  Message m = Message();
  String? sendMessage;
  bool reverse = true;
  @override
  void initState() {
    Future.delayed(Duration.zero).whenComplete(() {
      ref.read(messageRef).setMessageCount = 0;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [IconButton(onPressed: (() {}), icon: Icon(Icons.abc))],
          centerTitle: true,
          title: const Text("Mesajlaşma"),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: reverse,
                itemCount: messages.length,
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
                          child: Text("${messages[index]}"),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: TextField(
                        onChanged: (value) {
                          sendMessage = value;
                        },
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        reverse = false;
                        messages.add(sendMessage);
                      });
                    },
                    child: const Text("Gönder")),
                const SizedBox(
                  width: 8,
                )
              ],
            ),
          ],
        ));
  }
}
