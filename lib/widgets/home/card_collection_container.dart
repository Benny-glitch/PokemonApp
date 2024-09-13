import 'package:flutter/material.dart';
import 'card_image.dart';

class CardCollectionContainer extends StatelessWidget {
  final double totCost;

  const CardCollectionContainer({required this.totCost, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(left: 25.0, right: 25.0, top: 18.0, bottom: 0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'V & Vstar group',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '20 ITEMS',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ]),
              Text(
                'Total value\n \$ $totCost',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Divider(thickness: 0.3),
          const SizedBox(height: 16.0),
          LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth;
              int cardCount;

              if (width > 300) {
                cardCount = 3;
              } else if (width > 200) {
                cardCount = 2;
              } else {
                cardCount = 1;
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(cardCount, (index) {
                  return const Flexible(
                    child: CardImage(
                      imageUrl: 'assets/zapdos_v.jpg',
                      count: 10,
                    ),
                  );
                }),
              );
            },
          ),

          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: TextButton(
                  onPressed: () {
                    // Add the logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade50,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Add cards',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                flex: 2,
                child: OutlinedButton(
                  onPressed: () {
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.grey.shade50,
                    minimumSize: const Size.fromHeight(50),
                    alignment: Alignment.center,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    side: BorderSide(width: 1, color: Colors.grey.shade100),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}