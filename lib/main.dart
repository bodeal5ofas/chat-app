import 'package:chat/add_room/add_room.dart';
import 'package:chat/chat/chat_screen.dart';
import 'package:chat/firebase_options.dart';
import 'package:chat/home/home_screen.dart';
import 'package:chat/login/login_screen.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: const ChatApp()));
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:userProvider.currentUser==null? LoginScreen.id : HomeScreen.id,
      routes: {
        RegisterScreen.id: (context) => const RegisterScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        AddRoom.id:(context)=>const AddRoom(),
        ChatScreen.id:(context)=>const ChatScreen(),
      },
    );
  }
}
