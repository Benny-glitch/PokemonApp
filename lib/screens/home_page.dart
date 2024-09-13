import 'package:flutter/material.dart';
import 'package:pokemon_card_collector/widgets/home_page/bottom_fixed_widget.dart';
import 'package:pokemon_card_collector/widgets/home_page/card_collection_container.dart';
import 'package:pokemon_card_collector/widgets/home_page/draggable_sheet.dart';

import '../widgets/home_page/carousel_notice.dart';

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
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 12,
            ),
            child: CarouselNotice(),
          ),
          const MyDraggableSheet(
            child: Column(
              children: [
                CardCollectionContainer(totCost: 250.12),
                CardCollectionContainer(totCost: 250.12),
                CardCollectionContainer(totCost: 250.12),
                CardCollectionContainer(totCost: 250.12),
                CardCollectionContainer(totCost: 250.12),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomFixedWidget(),
          ),
        ],
      ),
    );
  }
}