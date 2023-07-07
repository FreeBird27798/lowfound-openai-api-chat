import 'package:flutter/material.dart';
import 'package:lowfound_openai_api_chat/api/open_ai_repository.dart';
import 'package:lowfound_openai_api_chat/constants/api_constants.dart';
import 'package:lowfound_openai_api_chat/model/message.dart';
import 'package:lowfound_openai_api_chat/storage/database/controllers/messages_db_controller.dart';
import 'package:provider/provider.dart';

class MessagesProvider with ChangeNotifier {
  List<Message> messages = <Message>[];

  static MessagesProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<MessagesProvider>(context, listen: listen);

  MessagesProvider() {
    read();
  }

  Future<void> read() async {
    messages = await MessagesDbController().read();
    notifyListeners();
  }

  Future<bool> create(Message message) async {
    int id = await MessagesDbController().create(message);
    if (id != 0) {
      message.id = id;
      messages.add(message);
      notifyListeners();
    }
    return false;
  }

  Future<bool> delete(int id) async {
    bool deleted = await MessagesDbController().delete(id);
    if (deleted) {
      messages.removeWhere((element) => element.id == id);
      notifyListeners();
    }
    return deleted;
  }

  Future<void> sendMessageAndGetAnswers({required Message message}) async {
    Message receivedMessage = await OpenAiRepository.sendMessage(
      messageObject: message,
      modelId: ApiConstants.modelId,
    );
    await create(receivedMessage);
    notifyListeners();
  }
}
