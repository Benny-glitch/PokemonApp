import 'package:flutter/material.dart';
import 'package:pokemon_card_collector/screens/explore_page.dart';
import 'package:pokemon_card_collector/widgets/home_page/bottom_fixed_widget.dart';
import 'package:pokemon_card_collector/widgets/home_page/card_collection_container.dart';
import 'package:pokemon_card_collector/widgets/home_page/draggable_sheet.dart';
import '../widgets/home_page/carousel_notice.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DraggableScrollableController sheetController = DraggableScrollableController();

  bool isExploreSelected = true;

  final List<Widget> _pages = [

    const Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: CarouselNotice(),
        ),
        MyDraggableSheet(
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
      ],
    ),
    const ExplorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.black,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text(
            'PokeDesk',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 28,
            ),
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _pages[isExploreSelected ? 0 : 1],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomFixedWidget(
              onSwitchChange: (bool isExplore) {
                setState(() {
                  isExploreSelected = isExplore;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
