import 'package:flutter/material.dart';

import 'card_image.dart';

class CardCollectionContainer extends StatelessWidget {
  final double totCost;

  const CardCollectionContainer({required this.totCost, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
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
                ]
              ),
              Text(
                'Total value\n \$ $totCost',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const Divider(thickness: 0.5),
          const SizedBox(height: 16.0),
          SizedBox(
            height: 130.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                CardImage(
                  imageUrl: 'assets/moltres_v.jpg',
                  count: 5,
                ),
                CardImage(
                  imageUrl: 'assets/arceus_v.jpg',
                  count: 2,
                ),
                CardImage(
                  imageUrl: 'assets/zapdos_v.jpg',
                  count: 10,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          TextButton(
            onPressed: () {
              // Aggiungi la logica per il pulsante "Add cards"
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple.shade900, // Arancione chiaro
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
        ],
      ),
    );
  }
}