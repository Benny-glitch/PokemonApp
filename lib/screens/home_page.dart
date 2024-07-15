import 'package:flutter/material.dart';
import 'package:pokemon_card_collector/widgets/card_collection_container.dart';
import 'package:pokemon_card_collector/widgets/draggable_sheet.dart';

class HomePage extends StatelessWidget {
  final DraggableScrollableController sheetController =
  DraggableScrollableController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Text(
            'PokeDesk',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 28,
            ),
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey,
      body: const MyDraggableSheet(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardCollectionContainer(totCost: 250.12),
            CardCollectionContainer(totCost: 250.12),
          ]
        ),
      ),
    );
  }
}