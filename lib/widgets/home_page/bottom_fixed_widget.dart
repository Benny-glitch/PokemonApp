import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_card_collector/screens/create_collection_page.dart';
import 'package:pokemon_card_collector/widgets/home_page/sliding_switch_widget.dart';

class BottomFixedWidget extends StatelessWidget {
  const BottomFixedWidget({super.key});
  static const double height = 185;

  @override
  Widget build(BuildContext context) {
    bool val = true;
    return Container(
      height: 160,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateCollectionPage(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              child:
              const Row(
                  children: [
                    Icon(Icons.folder, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('Create new collection'),
                    Spacer(),
                    Icon(Icons.add, color: Colors.black),
                  ],
                ),
              ),
          ),
          const SizedBox(height: 13),
          SlidingSwitch(
            value: val,
            onChanged: (bool onChangeValue) {
              val = onChangeValue;
            },
            height: 45,
            animationDuration: const Duration(milliseconds: 75),
            onTap: () {},
            onDoubleTap: () {},
            onSwipe: () {},
            textOff: "Explore",
            textOn: "Collection",
            colorOn: const Color(0xffE5622E),
            colorOff: const Color(0xffE5622E),
            background: Colors.grey.shade200,
            buttonColor: Colors.white,
            inactiveColor: Colors.black38,
            iconOff: Icons.zoom_in,
            iconOn: Icons.collections_bookmark,
          )
        ],
      ),
    );
  }
}



