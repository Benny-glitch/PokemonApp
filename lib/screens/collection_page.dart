import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../models/card.dart';
import '../models/card_collection.dart';
import '../services/hive_service.dart';
import '../widgets/collection_page/card_item.dart';

class CollectionPage extends StatefulWidget {
  final String collectionDescription;
  final String collectionName;

  const CollectionPage({
    Key? key,
    required this.collectionName,
    required this.collectionDescription,
  }) : super(key: key);

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  late String currentCollectionName;
  late String currentCollectionDescription;

  @override
  void initState() {
    super.initState();
    currentCollectionName = widget.collectionName;
    currentCollectionDescription = widget.collectionDescription;
  }

  Future<void> _updateCollectionName(String newName) async {
    final hiveService = Provider.of<HiveService>(context, listen: false);
    try {
      // Aggiungi qui il metodo per aggiornare il nome della collezione
      await hiveService.updateCollectionName(currentCollectionName, newName);
      setState(() {
        currentCollectionName = newName;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error updating name: ${e.toString()}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Future<CardCollection> _fetchCollection(BuildContext context) async {
    final hiveService = Provider.of<HiveService>(context, listen: false);
    return await hiveService.getCollectionByName(currentCollectionName);
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
      title: Text(currentCollectionName), // Usa currentCollectionName
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOutlinedIconButton(Icons.edit, () {
                _showEditNameDialog(context);
              }),
              const SizedBox(width: 20),
              _buildOutlinedIconButton(Icons.delete, () {
                _showDeleteConfirmationDialog(context);
              }),
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
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: Icon(icon, color: Colors.black, size: 20.0),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: const Text('Elimination'),
          content: const Text(
              'Are you sure you want to delete this collection? This action cannot be undone.'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                try {
                  final hiveService =
                  Provider.of<HiveService>(context, listen: false);
                  await hiveService.deleteCollectionByName(currentCollectionName);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                    msg: 'Collection successfully eliminated!',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                  );
                } catch (e) {
                  Fluttertoast.showToast(
                    msg: 'Error during elimination: ${e.toString()}',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w100,
                color: Colors.grey.shade500),
          ),
          FutureBuilder<CardCollection>(
            future: _fetchCollection(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('No data available');
              } else {
                final cardCollection = snapshot.data!;
                return Text(
                  '\$${cardCollection.totCost.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
                );
              }
            },
          ),
          const SizedBox(height: 28),
          Text(
            'About Collection',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w100,
                color: Colors.grey.shade500),
          ),
          const SizedBox(height: 8),
          Text(currentCollectionDescription), // Usa currentCollectionDescription
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  void _showEditNameDialog(BuildContext context) {
    final TextEditingController _controller =
    TextEditingController(text: currentCollectionName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Collection Name'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'New collection name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newName = _controller.text.trim();
                if (newName.isNotEmpty && newName != currentCollectionName) {
                  _updateCollectionName(newName);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCardGrid(BuildContext context, CardCollection cardCollection) {
    Map<String, List<PokemonCard>> groupedCards = {};

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    for (var card in cardCollection.cards) {
      String? setName = card.set?.name;
      if (setName != null && setName.isNotEmpty) {
        if (!groupedCards.containsKey(setName)) {
          groupedCards[setName] = [];
        }
        groupedCards[setName]!.add(card);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Center(
        child: Column(
          children: groupedCards.entries.map((entry) {
            String setName = entry.key;
            List<PokemonCard> cardsInSet = entry.value;
            String seriesName = cardsInSet.isNotEmpty
                ? (cardsInSet.first.set?.series ?? 'Unknown Series')
                : 'Unknown Series';
            String? setLogoUrl = cardsInSet.isNotEmpty
                ? cardsInSet.first.set?.images?.logo
                : null;

            return Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, spreadRadius: 0.5)
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(seriesName,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      minTileHeight: 0.05 * height,
                      collapsedBackgroundColor: Colors.transparent,
                      shape: Border.all(color: Colors.transparent),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (setLogoUrl != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Image.network(
                                setLogoUrl,
                                width: 0.3 * width,
                                height: 0.1 * height,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.image_not_supported,
                                      size: 40, color: Colors.grey);
                                },
                              ),
                            ),
                          Expanded(
                            child: Text(
                              setName,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ),
                        ],
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
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12, spreadRadius: 0.5)
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(
                                  color: Colors.grey,
                                  height: 1.0,
                                  thickness: 0.3),
                              Padding(
                                padding: EdgeInsets.all(width * 0.020),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 16),
                                    const Text('Collection',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 8),
                                    LinearProgressIndicator(
                                      value: 0.25,
                                      backgroundColor: Colors.grey[300],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.orange),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text('25%',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black)),
                                              Text('3 - 230 cards',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.orange)),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              const Text('Total value',
                                                  style:
                                                  TextStyle(fontSize: 16)),
                                              Text(
                                                '\$${cardsInSet.fold<double>(0.0, (sum, card) => sum + (card.cardmarket?.prices?.averageSellPrice ?? 0.0)).toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                  color: Colors.grey,
                                  height: 1.0,
                                  thickness: 0.3),
                              Padding(
                                padding: EdgeInsets.all(width * 0.020),
                                child: DynamicHeightGridView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  itemCount: cardsInSet.length,
                                  builder: (context, index) {
                                    final card = cardsInSet[index];
                                    return CardItem(
                                      imageUrl: card.images?.large ??
                                          'https://placehold.co/600x400/png',
                                      cardType: card.rarity ?? 'Unknown Type',
                                      cardName: card.name,
                                      price: card.cardmarket?.prices
                                          ?.averageSellPrice !=
                                          null
                                          ? '\$${card.cardmarket?.prices?.averageSellPrice?.toStringAsFixed(2)}'
                                          : 'N/A',
                                      quantity: card.cardsHeld,
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
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CardCollection>(
      future: _fetchCollection(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        } else {
          final cardCollection = snapshot.data!;

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
                        _buildCardGrid(context, cardCollection),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
