import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lowfound_openai_api_chat/constants/constants.dart';
import 'package:lowfound_openai_api_chat/model/message.dart';

import 'app_text.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  final VoidCallback onDelete;

  const MessageCard({
    required this.message,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('dd MMMM yyyy HH:mm').format(message.createdAt),
              style: TextStyle(color: dateColor, fontSize: 16),
            ),
            SizedBox(
              height: 12,
            ),
            AppText(
              label: 'You asked:',
              textColor: blueColor,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              '${message.message}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 12,
            ),
            AppText(
              label: 'GPT responded:',
              textColor: blueColor,
            ),
            SizedBox(
              height: 4,
            ),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('${message.response.trim()}',
                    textStyle: TextStyle(fontSize: 16),
                    textAlign: TextAlign.start),
              ],
              totalRepeatCount: 1,
              onTap: () {
                print("Tap Event");
              },
            ),
            SizedBox(
              height: 12,
            ),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.zero),
              ),
              onPressed: onDelete,
              child: AppText(label: 'Delete', textColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
