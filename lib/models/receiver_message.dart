import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReceiverMessage {
  final String message;
  final String channelId;
  ReceiverMessage({
    required this.message,
    required this.channelId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'channelId': channelId,
    };
  }

  factory ReceiverMessage.fromMap(Map<String, dynamic> map) {
    return ReceiverMessage(
      message: map['message'] as String,
      channelId: map['channelId'] as String,
    );
  }

  factory ReceiverMessage.fromJson(String source) =>
      ReceiverMessage.fromMap(json.decode(source) as Map<String, dynamic>);
}
