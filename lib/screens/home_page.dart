import 'package:flutter/material.dart';
import 'package:pokemon_card_collector/screens/explore_page.dart';
import 'package:pokemon_card_collector/widgets/home_page/bottom_fixed_widget.dart';
import 'package:pokemon_card_collector/widgets/home_page/card_collection_container.dart';
import 'package:pokemon_card_collector/widgets/home_page/draggable_sheet.dart';
import '../widgets/home_page/carousel_notice.dart';
import 'create_collection_form.dart';

class HomePage extends StatefulWidget {
  final DraggableScrollableController sheetController =
  DraggableScrollableController();

  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DraggableScrollableController sheetController = DraggableScrollableController();

  bool isExploreSelected = true;

  bool _isFormVisible = false;

  void _toggleFormVisibility() {
    setState(() {
      _isFormVisible = !_isFormVisible;
    });
  }

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
        surfaceTintColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text(
            'PokeDesk',
            style: TextStyle(
              color: Colors.black,
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
          _pages[isExploreSelected ? 0 : 1],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomFixedWidget(
              onCreateCollectionTap: _toggleFormVisibility,
              onSwitchChange: (bool isExplore) {
                setState(() {
                  isExploreSelected = isExplore;
                });
              },
            ),
          ),

          if (_isFormVisible)
            CreateCollectionForm(
              onClose: _toggleFormVisibility,
            ),
        ],
      ),
    );
  }
}