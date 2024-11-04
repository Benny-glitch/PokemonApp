import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pokemon_card_collector/models/card_collection.dart';
import 'package:pokemon_card_collector/screens/collection_page.dart';
import 'package:pokemon_card_collector/widgets/home_page/place_holder_card.dart';
import '../../models/card.dart';
import 'card_image.dart';

class CardCollectionContainer extends StatelessWidget {
  final String collectionName;
  final String collectionDescription;
  final int collectionCardNumber;
  final List<PokemonCard> cards;

  const CardCollectionContainer({
    required this.collectionName,
    required this.collectionDescription,
    required this.collectionCardNumber,
    required this.cards,
    super.key,
  });

  Future<List<PokemonCard>> _fetchCardsFromCollection() async {
    var box = await Hive.openBox<CardCollection>('card_collections');
    var collection = box.values.firstWhere((c) => c.name == collectionName);
    return collection != null ? collection.cards : [];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CollectionPage(
              collectionName: collectionName,
              collectionDescription: collectionDescription,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 25.0, right: 25.0, top: 18.0),
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
              children: [
                ValueListenableBuilder(
                  valueListenable: Hive.box<CardCollection>('card_collections').listenable(),
                  builder: (context, Box<CardCollection> box, _) {
                    var collection = box.values.firstWhere((c) =>
                    c.name == collectionName);
                    int numCards = collection.cards.length;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$collectionName ',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$numCards ITEMS',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    );
                  }
                ),
                ValueListenableBuilder(
                  valueListenable: Hive.box<CardCollection>('card_collections').listenable(),
                  builder: (context, Box<CardCollection> box, _) {
                    var collection = box.values.firstWhere((c) => c.name == collectionName);
                    double totCost = collection.totCost;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Total value',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Transform.rotate(
                              angle: -1.5708,
                              child: const Icon(
                                Icons.arrow_outward,
                                color: Colors.green,
                                size: 15,
                              ),
                            ),
                            Text(
                              ' \$$totCost',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            const Divider(thickness: 0.3),
            const SizedBox(height: 16.0),
            LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth;
                int cardsToShow;

                if (width > 300) {
                  cardsToShow = 3;
                } else if (width > 200) {
                  cardsToShow = 2;
                } else {
                  cardsToShow = 1;
                }

                return FutureBuilder<List<PokemonCard>>(
                  future: _fetchCardsFromCollection(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: snapshot.data!
                            .take(cardsToShow)
                            .map((card) => Padding(
                          padding: EdgeInsets.only(right: width * 0.020, left: width * 0.020),
                          child: CardImage(card: card, count: 0),
                        ))
                            .toList(),
                      );
                    } else {
                      return const PlaceholderCard();
                    }
                  },
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
                      // Logica per aggiungere carte
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
