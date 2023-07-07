import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lowfound_openai_api_chat/constants/assets.dart';
import 'package:lowfound_openai_api_chat/constants/constants.dart';
import 'package:lowfound_openai_api_chat/model/message.dart';
import 'package:lowfound_openai_api_chat/providers/messages_provider.dart';
import 'package:lowfound_openai_api_chat/providers/theme_provider.dart';
import 'package:lowfound_openai_api_chat/storage/preferences/app_pref_controller.dart';
import 'package:lowfound_openai_api_chat/ui/widgets/app_text_field.dart';
import 'package:lowfound_openai_api_chat/ui/widgets/message_card.dart';
import 'package:lowfound_openai_api_chat/ui/widgets/app_text.dart';
import 'package:lowfound_openai_api_chat/utils/helpers.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> with Helpers {
  bool _isTyping = false;
  bool _enabled = false;
  String _message = '';

  late TextEditingController _textEditingController;
  late ScrollController _listScrollController;

  @override
  void initState() {
    _listScrollController = ScrollController();
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MessagesProvider>(context).read();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        toolbarHeight: 80,
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 24,
            height: 24,
            child: Image.asset(
              AssetsManager.openaiLogo,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.all(8.0),
          child: AppText(
            label: "LowFound OpenAI API Chat",
            fontSize: 20,
          ),
        ),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              final isLightTheme =
                  themeProvider.getThemeMode() == ThemeMode.light;
              return PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    enabled: true,
                    child: Consumer<ThemeProvider>(
                      builder: (context, themeProvider, _) {
                        return Row(
                          children: [
                            Icon(
                                isLightTheme
                                    ? Icons.brightness_4
                                    : Icons.brightness_7,
                                color:
                                    isLightTheme ? blackColor : Colors.white),
                            SizedBox(width: 12),
                            Text(isLightTheme ? "Dark Mode" : "Light Mode"),
                          ],
                        );
                      },
                    ),
                    value: "toggle_theme",
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.logout,
                            color: isLightTheme ? blackColor : Colors.white),
                        SizedBox(width: 12),
                        Text("Logout"),
                      ],
                    ),
                    value: "logout",
                  ),
                ],
                onSelected: (value) async {
                  if (value == "logout") {
                    await logout(context);
                  } else if (value == "toggle_theme") {
                    final themeProvider =
                        Provider.of<ThemeProvider>(context, listen: false);
                    themeProvider.toggleTheme();
                  }
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<MessagesProvider>(
          builder: (
            BuildContext context,
            MessagesProvider messagesProvider,
            Widget? child,
          ) {
            return Column(
              children: [
                Expanded(
                  child: messagesProvider.messages.isEmpty
                      ? _isTyping
                          ? Consumer<ThemeProvider>(
                              builder: (context, themeProvider, _) {
                                final isLightTheme =
                                    themeProvider.getThemeMode() ==
                                        ThemeMode.light;
                                return SpinKitThreeBounce(
                                  color: isLightTheme
                                      ? greyColor.withOpacity(0.5)
                                      : Colors.white,
                                );
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Your chat is empty. Send your first message to start a chat.',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListView.builder(
                              controller: _listScrollController,
                              itemCount: messagesProvider.messages.length,
                              itemBuilder: (context, index) {
                                Message message =
                                    messagesProvider.messages[index];
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: MessageCard(
                                    message: message,
                                    onDelete: () async {
                                      await deleteMessage(message.id, index);
                                    },
                                  ),
                                );
                              }),
                        ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Material(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            enablePadding: true,
                            textEditingController: _textEditingController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) => validateForm(),
                            hintText: 'Type your message here...',
                          ),
                        ),
                        _isTyping
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Consumer<ThemeProvider>(
                                  builder: (context, themeProvider, _) {
                                    final isLightTheme =
                                        themeProvider.getThemeMode() ==
                                            ThemeMode.light;
                                    return SpinKitThreeBounce(
                                      color: isLightTheme
                                          ? greyColor.withOpacity(0.5)
                                          : Colors.white,
                                      size: 18,
                                    );
                                  },
                                ),
                              )
                            : IconButton(
                                onPressed: _enabled
                                    ? () async => await performSendMessage(
                                        messagesProvider: messagesProvider)
                                    : null,
                                icon: Icon(
                                  Icons.send,
                                  size: _enabled ? 26 : 24,
                                ))
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // void scrollListToEND() {
  //   _listScrollController.animateTo(
  //       _listScrollController.position.maxScrollExtent,
  //       duration: const Duration(seconds: 2),
  //       curve: Curves.easeOut);
  // }

  bool checkMessage() {
    return _textEditingController.text.isNotEmpty;
  }

  void validateForm() {
    updateEnableStatus(checkMessage());
  }

  void updateEnableStatus(bool status) {
    setState(() {
      _enabled = status;
    });
  }

  Future<void> performSendMessage(
      {required MessagesProvider messagesProvider}) async {
    if (checkMessage()) {
      await sendMessage(messagesProvider: messagesProvider);
    }
  }

  Future<void> sendMessage({required MessagesProvider messagesProvider}) async {
    if (_isTyping) {
      showSnackBar(context,
          message: 'You can\'t send multiple messages at a time');
      return;
    }
    try {
      setState(() {
        _isTyping = true;
        _message = _textEditingController.text;
        _textEditingController.clear();
      });
      await messagesProvider.sendMessageAndGetAnswers(message: message);
      setState(() {});
    } catch (error) {
      log("error $error");
      showSnackBar(context, message: error.toString(), error: true);
    } finally {
      setState(() {
        _isTyping = false;
        _enabled = false;
        // scrollListToEND();
      });
    }
  }

  Message get message {
    Message newMessage = Message();
    newMessage.message = _message;
    newMessage.createdAt = DateTime.now();
    newMessage.userId = AppPrefController().user.id;
    return newMessage;
  }

  Future<void> logout(BuildContext context) async {
    bool status = await AppPrefController().logout();
    if (status) {
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
  }

  Future deleteMessage(int id, int index) async {
    await Provider.of<MessagesProvider>(context, listen: false).delete(id);
  }
}
