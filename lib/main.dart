import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pokemon_card_collector/screens/home_page.dart';
import 'package:pokemon_card_collector/services/card_service.dart';
import 'package:provider/provider.dart';

import 'models/card_collection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(CardCollectionAdapter());
  runApp(MultiProvider(
    providers: [
      Provider<CardService>(create: (_) => CardService()),
    ],
    child: MyApp(),
  ),);
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