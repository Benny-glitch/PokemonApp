import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_card_collector/screens/explore_page.dart';
import 'package:pokemon_card_collector/services/hive_service.dart';
import 'package:pokemon_card_collector/widgets/home_page/bottom_fixed_widget.dart';
import 'package:pokemon_card_collector/widgets/home_page/card_collection_container.dart';
import 'package:pokemon_card_collector/widgets/home_page/draggable_sheet.dart';
import '../models/card_collection.dart';
import '../widgets/home_page/carousel_notice.dart';
import 'create_collection_form.dart';

class HomePage extends StatefulWidget {
  final DraggableScrollableController sheetController =
      DraggableScrollableController();
  final FocusNode searchFocusNode = FocusNode();

  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  bool _isFormVisible = false;

  late HiveService _hiveService;
  bool _isHiveInitialized = false;

  @override
  void initState() {
    super.initState();
    _hiveService = Provider.of<HiveService>(context, listen: false);
    _initializeHive();

  }

  Future<void> _initializeHive() async {
    await _hiveService.init();
    setState(() {
      _isHiveInitialized = true;
    });
  }

  void _toggleFormVisibility() {
    setState(() {
      _isFormVisible = !_isFormVisible;
    });
  }

  void _addNewCollection(String name, String description) async {
    try {
      final newCollection =
          CardCollection(name: name, description: description, totCost: 0);
      await _hiveService.addCollection(newCollection);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Errore: ${e.toString()}")),
      );
    }
  }

  void _switchPage(int index) {
    if (index != _currentPageIndex) {
      widget.searchFocusNode.unfocus();
      setState(() {
        _currentPageIndex = index;
      });
    }
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
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey,
      resizeToAvoidBottomInset: false,
      body: _isHiveInitialized
          ? Stack(
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
                        ValueListenableBuilder(
                          valueListenable: _hiveService.box.listenable(),
                          builder: (context, Box<CardCollection> box, _) {
                            final collections =
                                _hiveService.getAllCollections();
                            return MyDraggableSheet(
                              child: Column(
                                children: collections.map((collection) {
                                  return CardCollectionContainer(
                                    collectionName: collection.name,
                                    collectionDescription:
                                        collection.description,
                                    collectionCardNumber:
                                        collection.cards.length,
                                    cards: collection.cards,
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    ExplorePage(focusNode: widget.searchFocusNode),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BottomFixedWidget(
                    onCreateCollectionTap: _toggleFormVisibility,
                    onSwitchChange: (bool isExplore) {
                      _switchPage(isExplore ? 0 : 1);
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
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
