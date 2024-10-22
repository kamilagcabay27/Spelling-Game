import 'package:flutter/material.dart';
import 'package:flutter_spelling_game/controller/controller.dart';
import 'package:flutter_spelling_game/view/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => Controller(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spelling Bee',
      theme: ThemeData(
          textTheme: const TextTheme(
              displayLarge: TextStyle(
                  fontFamily: 'PartyConfetti',
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))),
      home: const HomePage(),
    );
  }
}
