import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SenderMessage {
  final String message;
  final String channelId;
  final int channelType;
  SenderMessage({
    required this.message,
    required this.channelId,
    required this.channelType,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'channelId': channelId,
      'channelType': channelType,
    };
  }

  factory SenderMessage.fromMap(Map<String, dynamic> map) {
    return SenderMessage(
      message: map['message'] as String,
      channelId: map['channelId'] as String,
      channelType: map['channelType'] as int,
    );
  }

  factory SenderMessage.fromJson(String source) =>
      SenderMessage.fromMap(json.decode(source) as Map<String, dynamic>);
}
