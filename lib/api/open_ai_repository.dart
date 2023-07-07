import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lowfound_openai_api_chat/constants/api_constants.dart';
import 'package:lowfound_openai_api_chat/model/message.dart';

class OpenAiRepository {
  static var client = http.Client();

  static Future<Message> sendMessage(
      {required Message messageObject, required String modelId}) async {
    try {
      log("modelId $modelId");
      var response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/completions"),
        headers: {
          'Authorization': 'Bearer ${ApiConstants.apiKey}',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": modelId,
            "prompt": messageObject.message,
            "max_tokens": 300,
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }
      if (jsonResponse["choices"].length > 0) {
        messageObject.response = jsonResponse["choices"][0]["text"];
      }
      return messageObject;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
