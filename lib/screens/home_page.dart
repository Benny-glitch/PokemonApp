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
  int _currentPageIndex = 0;
  bool _isFormVisible = false;

  final List<Widget> _collections = [];

  void _toggleFormVisibility() {
    setState(() {
      _isFormVisible = !_isFormVisible;
    });
  }

  void _addNewCollection(String name, String description) {
    setState(() {
      _collections.add(CardCollectionContainer(
        totCost: 0,
        collectionName: name,
        collectionDescription: description,
      ));
    });
  }

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
          IndexedStack(
            index: _currentPageIndex,
            children: [
              Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: CarouselNotice(),
                  ),
                  MyDraggableSheet(
                    child: Column(
                      children: _collections,
                    ),
                  ),
                ],
              ),
              const ExplorePage(),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomFixedWidget(
              onCreateCollectionTap: _toggleFormVisibility,
              onSwitchChange: (bool isExplore) {
                setState(() {
                  _currentPageIndex = isExplore ? 0 : 1;
                });
              },
            ),
          ),
          if (_isFormVisible)
            CreateCollectionForm(
              onClose: _toggleFormVisibility,
              onSave: (String name, String description) {
                _addNewCollection(name, description);
                _toggleFormVisibility();
              },
            ),
        ],
      ),
    );
  }
}
