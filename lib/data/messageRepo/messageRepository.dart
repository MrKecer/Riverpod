import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/messages/message.dart';

class Message extends ChangeNotifier {
  List<SendMessage> m = [
    SendMessage("Yusuf", "Keçer", DateTime.now()),
    SendMessage("Yusuwqef", "Kesdfçer", DateTime.now()),
    SendMessage("Yusasduf", "Keçeasdr", DateTime.now()),
    SendMessage("Yuadfsuf", "Kadeçer", DateTime.now()),
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

  sendMessage(String value) {
    m.add(SendMessage(value, "", DateTime.now()));
    notifyListeners();
  }
}

final messageRef = ChangeNotifierProvider((ref) {
  return Message();
});
