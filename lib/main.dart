import 'package:flutter/material.dart';
import 'package:pokemon_card_collector/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedesk App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'TTCommon',
      ),
      home: HomePage(),
    );
  }
}