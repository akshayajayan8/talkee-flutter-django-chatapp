import 'package:chatapp/screens/SplashScreen.dart';
import 'package:chatapp/themes/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences userdata;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  userdata = await SharedPreferences.getInstance();
  runApp(const Chat());
}

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  // This widget is the root of your application.
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: darkMode,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
  }
}
