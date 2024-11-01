import 'package:flutter/material.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:pokemon_card_collector/screens/search_page.dart';

import '../widgets/explore_page/top_card_carousel.dart';
import '../widgets/home_page/bottom_fixed_widget.dart';

class ExplorePage extends StatefulWidget {
  final FocusNode focusNode;

  const ExplorePage({super.key, required this.focusNode});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  void _navigateToSearchPage() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => SearchPage(),
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            ), child: Text('Search for a card'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                DynamicHeightGridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  itemCount: 4,
                  builder: (context, index) {
                    final buttonData = [
                      {
                        'label': 'Price',
                        'gradient': [Colors.red, Colors.redAccent]
                      },
                      {
                        'label': 'Moves',
                        'gradient': [Colors.orange, Colors.deepOrangeAccent]
                      },
                      {
                        'label': 'Evolutions',
                        'gradient': [Colors.greenAccent, Colors.green.shade700]
                      },
                      {
                        'label': 'Types',
                        'gradient': [Colors.lightBlueAccent, Colors.blue.shade700]
                      },
                    ];

                    return _buildGradientButton(
                      context,
                      buttonData[index]['label'] as String,
                      buttonData[index]['gradient'] as List<Color>,
                    );
                  },
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
                const TopCardsCarousel(),
                const Padding(
                  padding: EdgeInsets.only(bottom: BottomFixedWidget.height),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton(
      BuildContext context, String label, List<Color> gradientColors) {
    return SizedBox(
      height: 70,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
