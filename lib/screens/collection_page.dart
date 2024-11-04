import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pokemon_card_collector/widgets/collection_page/bottom_widget.dart';
import 'package:pokemon_card_collector/widgets/collection_page/card_item.dart';
import '../widgets/collection_page/search_bar.dart';
import '../models/card_collection.dart';

class CollectionPage extends StatelessWidget {
  final String collectionDescription;
  final String collectionName;

  const CollectionPage({
    super.key,
    required this.collectionName,
    required this.collectionDescription,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: _fetchCollection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        } else {
          final cardCollection = snapshot.data as CardCollection;

          return Scaffold(
            backgroundColor: Colors.grey.shade50,
            appBar: _buildAppBar(context),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildCollectionHeader(cardCollection),
                        Divider(height: 1, color: Colors.grey.shade200),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: AutoCompleteSearchWidget(),
                        ),
                        _buildCardGrid(context, cardCollection, width),
                      ],
                    ),
                  ),
                ),
                const BottomWidget(),
              ],
            ),
          );
        }
      },
    );
  }

  Future<CardCollection> _fetchCollection() async {
    var box = await Hive.openBox<CardCollection>('card_collections');
    return box.values.firstWhere((collection) => collection.name == collectionName);
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: Colors.grey, height: 0.3),
      ),
      toolbarHeight: 80,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 20.0),
      ),
      title: Text(collectionName),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOutlinedIconButton(Icons.edit, () {}),
              const SizedBox(width: 20),
              _buildOutlinedIconButton(Icons.more_horiz_outlined, () {}),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOutlinedIconButton(IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 40.0,
      height: 40.0,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 1, color: Colors.grey.shade200),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: Icon(icon, color: Colors.black, size: 20.0),
      ),
    );
  }

  Widget _buildCollectionHeader(CardCollection cardCollection) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(
            'Total Value',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100, color: Colors.grey.shade500),
          ),
          Text(
            '\$${cardCollection.totCost.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 28),
          Text(
            'About Collection',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 8),
          Text(collectionDescription),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildCardGrid(BuildContext context, CardCollection cardCollection, double width) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [BoxShadow(color: Colors.black12, spreadRadius: 0.5)],
          ),
          child: Column(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.all(16.0),
                child: const Text('Spada e Scudo'),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  minTileHeight: 85,
                  collapsedBackgroundColor: Colors.transparent,
                  shape: Border.all(color: Colors.transparent),
                  title: const Text(
                    'Brilliant Stars',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  children: [
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                        boxShadow: const [BoxShadow(color: Colors.black12, spreadRadius: 0.5)],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(color: Colors.grey, height: 1.0, thickness: 0.3),
                          Padding(
                            padding: EdgeInsets.all(width * 0.020),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                const Text('Collection', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                LinearProgressIndicator(
                                  value: 0.25,
                                  backgroundColor: Colors.grey[300],
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('25%', style: TextStyle(fontSize: 16, color: Colors.black)),
                                          Text('3 - 230 cards', style: TextStyle(fontSize: 16, color: Colors.orange)),
                                        ],
                                      ),
                                    ),
                                     Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          const Text('Total value', style: TextStyle(fontSize: 16)),
                                          Text('\$${cardCollection.totCost.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(color: Colors.grey, height: 1.0, thickness: 0.3),
                          Padding(
                            padding: EdgeInsets.all(width * 0.020),
                            child: DynamicHeightGridView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              itemCount: cardCollection.cards.length,
                              builder: (context, index) {
                                final card = cardCollection.cards[index];
                                return CardItem(
                                  imageUrl: card.images?.large ?? 'https://placehold.co/600x400/png',
                                  cardType: card.rarity ?? 'Unknown Type',
                                  cardName: card.name,
                                  price: card.cardmarket?.prices?.averageSellPrice != null
                                      ? '\$${card.cardmarket?.prices?.averageSellPrice?.toStringAsFixed(2)}'
                                      : 'N/A',
                                  quantity: 0,
                                  badgeAlignment: Alignment.bottomLeft,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
