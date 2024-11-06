import 'package:flutter/material.dart';
import 'package:pokemon_card_collector/screens/search_page.dart';
import 'package:pokemon_card_collector/widgets/explore_page/list_tile_button.dart';
import '../widgets/explore_page/top_card_carousel.dart';
import '../widgets/home_page/bottom_fixed_widget.dart';
import 'all_sets_page.dart';

class ExplorePage extends StatefulWidget {
  final FocusNode focusNode;

  const ExplorePage({super.key, required this.focusNode});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<String> selectedSetName = [];
  String selectedPriceRange = 'Any';
  String selectedType = 'Any';
  RangeValues _currentRangeValues = const RangeValues(0, 5000);
  List<String> selectedTypes = [];

  final List<String> allTypes = [
    "Colorless",
    "Darkness",
    "Dragon",
    "Fairy",
    "Fighting",
    "Fire",
    "Grass",
    "Lightning",
    "Metal",
    "Psychic",
    "Water"
  ];

  void _navigateToSearchPage() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => SearchPage(
          selectedSetName: selectedSetName,
          selectedTypes: selectedTypes,
          rangeValues: _currentRangeValues,
        ),
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  void _navigateToAllSetsPage() async {
    List<String> selectedSet = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AllSetsPage(initiallySelectedSets: selectedSetName,),
        ));
    

    if (selectedSet != []){
      setState(() {
        selectedSetName = selectedSet;
      });
    }
  }

  Future<void> _refreshTopCards() async {
    setState(() {});
  }

  void _showTypeSelectionMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        List<String> tempSelectedTypes = List.from(selectedTypes);
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Select Pokémon Types',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: allTypes.map((type) {
                        return CheckboxListTile(
                          title: Text(
                            type,
                            style: const TextStyle(color: Colors.white),
                          ),
                          value: tempSelectedTypes.contains(type),
                          onChanged: (bool? selected) {
                            setModalState(() {
                              if (selected == true) {
                                tempSelectedTypes.add(type);
                              } else {
                                tempSelectedTypes.remove(type);
                              }
                            });
                          },
                          activeColor: Colors.white,
                          checkColor: Colors.black,
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      }).toList(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedTypes = tempSelectedTypes;
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showPriceSlider() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Select Price Range',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  RangeSlider(
                    values: _currentRangeValues,
                    min: 0,
                    max: 5000,
                    divisions: 100,
                    labels: RangeLabels(
                      '\$${_currentRangeValues.start.round()}',
                      '\$${_currentRangeValues.end.round()}',
                    ),
                    onChanged: (RangeValues values) {
                      setModalState(() {
                        _currentRangeValues = values;
                      });
                    },
                    inactiveColor: Colors.white,
                    activeColor: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedPriceRange =
                            '\$${_currentRangeValues.start.round()} - \$${_currentRangeValues.end.round()}';
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Confirm', style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshTopCards,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.black,
                Colors.black87,
              ],
              stops: [0.0, 3.0],
            ),
          ),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What Pokémon card are you looking for?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _navigateToSearchPage,
                    child: Hero(
                      tag: 'searchBarHero',
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey.shade900,
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.search_rounded, color: Colors.white),
                            SizedBox(width: 16.0),
                            DefaultTextStyle(
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.white54,
                              ),
                              child: Text('Search for a card'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomListTileButton(
                    name: 'Sets',
                    label: selectedSetName.isEmpty
                        ? 'Any'
                        : selectedSetName.join(', '),
                    onTap: _navigateToAllSetsPage,
                    gradientColors: [Colors.red, Colors.redAccent],
                  ),
                  const SizedBox(height: 15),
                  CustomListTileButton(
                    name: 'Price',
                    label: selectedPriceRange,
                    onTap: () {
                      _showPriceSlider();
                    },
                    gradientColors: [Colors.orange, Colors.deepOrangeAccent],
                  ),
                  const SizedBox(height: 15),
                  CustomListTileButton(
                    name: 'Types',
                    label: selectedTypes.isEmpty
                        ? 'Any'
                        : selectedTypes.join(', '),
                    onTap: () {
                      _showTypeSelectionMenu();
                    },
                    gradientColors: [Colors.green.shade700, Colors.green.shade500],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Top cards',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade800,
                    height: 1.0,
                    thickness: 0.4,
                  ),
                  const SizedBox(height: 20),
                  TopCardsCarousel(
                    onRefresh: _refreshTopCards,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: BottomFixedWidget.height),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
