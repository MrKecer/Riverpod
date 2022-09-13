import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Message extends ChangeNotifier {
  List<SendMessage> m = [
    SendMessage(
        "Yusuf", "Keçer", DateTime.now().subtract(const Duration(minutes: 1))),
    SendMessage("Yusuwqef", "Kesdfçer", DateTime.now()),
    SendMessage("Yusasduf", "Keçeasdr", DateTime.now()),
    SendMessage("Yuadfsuf", "Kadeçer",
        DateTime.now().subtract(const Duration(minutes: 1))),
  ];
  int? messageCount;

  get getMessageCount {
    messageCount ??= m.length;
    return messageCount;
  }

  set setMessageCount(message) {
    messageCount = message;
    messageCount;
    notifyListeners();
  }
}

final messageRef = ChangeNotifierProvider((ref) {
  return Message();
});

class SendMessage {
  String? text;
  String? send;
  DateTime? time;
  String? gender;

  SendMessage(this.text, this.send, this.time);
}
