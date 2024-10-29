import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_card_collector/widgets/explore_page/search_bar.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
        child: Padding(
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
              AutoCompleteSearchWidgetExplorePage(),
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
                      {'label': 'Price', 'gradient': [Colors.red, Colors.redAccent]},
                      {'label': 'Moves', 'gradient': [Colors.orange, Colors.deepOrangeAccent]},
                      {'label': 'Evolutions', 'gradient': [Colors.greenAccent, Colors.green.shade700]},
                      {'label': 'Types', 'gradient': [Colors.lightBlueAccent, Colors.blue.shade700]},
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton(BuildContext context, String label, List<Color> gradientColors) {
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
          onPressed: () {

          },
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
