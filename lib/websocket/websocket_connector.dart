import 'dart:convert';

import 'package:chat_like_app/models/receiver_message.dart';
import 'package:chat_like_app/models/sender_message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Websocket {
  late WebSocketChannel channel;

  Websocket();

  void connect(String userId) {
    final wsUrl = Uri.parse("ws://localhost:5292/ws?userId=$userId");
    channel = WebSocketChannel.connect(wsUrl);
    listen();
  }

  void listen() {
    channel.stream.listen((event) {
      var responseData = jsonDecode(event) as Map<String, dynamic>;
      var model = ReceiverMessage.fromMap(responseData);
    });
  }

  void send() {
    var message = jsonEncode(SenderMessage(
      message: "hello there",
      channelId: "123",
      channelType: 0,
    ));
    channel.sink.add(message);
  }
}
