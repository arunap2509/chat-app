import '../models/chat_preview.dart';

class ClassPreviewData {
  static List<ChatPreview> getChatPreviewData() {
    return <ChatPreview>[
      ChatPreview(
        userId: "1",
        userName: "Adam",
        lastMessageTime: DateTime(2023, 6, 12),
        lastMessage:
            "Hey there just checking, have you done with your assignments",
        unReadMessageCount: 1,
      ),
      ChatPreview(
        userId: "2",
        userName: "Jenifer",
        lastMessageTime: DateTime(2023, 6, 13),
        lastMessage: "Are you free on friday, can we go out for dinner",
        unReadMessageCount: 1,
      ),
      ChatPreview(
        userId: "3",
        userName: "James",
        lastMessageTime: DateTime(2023, 6, 5),
        lastMessage: "Ok 😁",
        unReadMessageCount: 0,
      ),
      ChatPreview(
        userId: "4",
        userName: "Clara",
        lastMessageTime: DateTime(2023, 6, 1),
        lastMessage: "Dont't text me back",
        unReadMessageCount: 0,
      )
    ];
  }
}
