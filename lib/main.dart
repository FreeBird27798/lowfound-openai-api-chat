import 'package:flutter/material.dart';
import 'package:lowfound_openai_api_chat/providers/messages_provider.dart';
import 'package:lowfound_openai_api_chat/providers/users_provider.dart';
import 'package:lowfound_openai_api_chat/providers/theme_provider.dart';
import 'package:lowfound_openai_api_chat/storage/database/db_provider.dart';
import 'package:lowfound_openai_api_chat/storage/preferences/app_pref_controller.dart';
import 'package:lowfound_openai_api_chat/ui/screens/message_screen.dart';
import 'package:lowfound_openai_api_chat/ui/screens/auth_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBProvider().initDatabase();
  await AppPrefController().initSharedPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UsersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MessagesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'LowFound OpenAI API Chat',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.getLightTheme(),
            darkTheme: themeProvider.getDarkTheme(),
            themeMode: themeProvider.getThemeMode(),
            initialRoute:
                AppPrefController().loggedIn ? '/chat_screen' : '/login_screen',
            routes: {
              '/login_screen': (context) => AuthScreen(),
              '/chat_screen': (context) => MessageScreen(),
            },
          );
        },
      ),
    );
  }
}