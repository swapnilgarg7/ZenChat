import 'chat_message.dart';
import 'package:dart_openai/openai.dart';

class ChatApi {
  static const _model = 'gpt-3.5-turbo';

  ChatApi() {
    OpenAI.apiKey = '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';
    // OpenAI.organization = 'zenchat';
  }

  Future<String> completeChat(List<ChatMessage> messages) async {
    final chatCompletion = await OpenAI.instance.chat.create(
      model: _model,
      messages: messages
          .map((e) => OpenAIChatCompletionChoiceMessageModel(
                role: e.isUserMessage ? 'user' : 'assistant',
                content: e.content,
              ))
          .toList(),
    );
    print(chatCompletion.choices);
    return chatCompletion.choices.first.message.content;
  }
}
