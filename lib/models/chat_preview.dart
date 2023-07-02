// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatPreview {
  String userId;
  String userName;
  DateTime lastMessageTime;
  String lastMessage;
  int unReadMessageCount;
  ChatPreview({
    required this.userId,
    required this.userName,
    required this.lastMessageTime,
    required this.lastMessage,
    required this.unReadMessageCount,
  });

  ChatPreview copyWith({
    String? userId,
    String? userName,
    DateTime? lastMessageTime,
    String? lastMessage,
    int? unReadMessageCount,
  }) {
    return ChatPreview(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      lastMessage: lastMessage ?? this.lastMessage,
      unReadMessageCount: unReadMessageCount ?? this.unReadMessageCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'lastMessageTime': lastMessageTime.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
      'unReadMessageCount': unReadMessageCount,
    };
  }

  factory ChatPreview.fromMap(Map<String, dynamic> map) {
    return ChatPreview(
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      lastMessageTime:
          DateTime.fromMillisecondsSinceEpoch(map['lastMessageTime'] as int),
      lastMessage: map['lastMessage'] as String,
      unReadMessageCount: map['unReadMessageCount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatPreview.fromJson(String source) =>
      ChatPreview.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatPreview(userId: $userId, userName: $userName, lastMessageTime: $lastMessageTime, lastMessage: $lastMessage, unReadMessageCount: $unReadMessageCount)';
  }
}
