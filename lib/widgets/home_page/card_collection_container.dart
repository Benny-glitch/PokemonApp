import 'package:flutter/material.dart';
import 'package:pokemon_card_collector/screens/collection_page.dart';
import 'card_image.dart';

class CardCollectionContainer extends StatelessWidget {
  final double totCost;
  final String collectionName;
  final String collectionDescription;

  const CardCollectionContainer(
      {required this.totCost,
      super.key,
      required this.collectionName,
      required this.collectionDescription});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CollectionPage(collectionName:collectionName, collectionDescription: collectionDescription),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
            left: 25.0, right: 25.0, top: 18.0, bottom: 0),
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    ' $collectionName ',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Total value',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.rotate(
                          angle: -1.5708,
                          child: Icon(
                            Icons.arrow_outward,
                            color: Colors.green,
                            size: 15,
                          ),
                        ),
                        Text(
                          ' \$$totCost',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                )
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
                    return Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: width * 0.020, left: width * 0.020),
                        child: CardImage(
                          imageUrl:
                              'https://images.pokemontcg.io/sm75/2_hires.png',
                          count: 10,
                        ),
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
                  flex: 14,
                  child: TextButton(
                    onPressed: () {
                      // Add the logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFDF7F4),
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
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      alignment: Alignment.center,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      side: BorderSide(width: 1.5, color: Colors.grey.shade100),
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
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final double totCost;

  const DetailsPage({required this.totCost, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page'),
      ),
      body: Center(
        child: Text(
          'Details for \$ $totCost',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
