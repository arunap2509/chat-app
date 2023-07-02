import 'package:chat_like_app/models/chat_preview.dart';

import '../DummyData/chat_preview_data.dart';

class ChatService {
  List<ChatPreview> chatPreviews = [];

  ChatService() {
    chatPreviews = ClassPreviewData.getChatPreviewData();
  }

  List<ChatPreview> getHomeScreenData() {
    return chatPreviews;
  }
}
