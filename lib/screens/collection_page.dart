import 'package:flutter/material.dart';
import 'package:pokemon_card_collector/widgets/collection_page/bottom_widget.dart';
import 'package:pokemon_card_collector/widgets/collection_page/card_item.dart';

import '../widgets/collection_page/search_bar.dart';

class CollectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 0.3,
          ),
        ),
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20.0,
          ),
        ),
        title: const Text('V & Vstar group'),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: OutlinedButton(
                    onPressed: () {
                      // Aggiungi l'azione che vuoi eseguire al clic del pulsante.
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 1, color: Colors.grey.shade200),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 20.0,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: OutlinedButton(
                    onPressed: () {
                      // Aggiungi l'azione che vuoi eseguire al clic del pulsante.
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 1, color: Colors.grey.shade200),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Icon(
                      Icons.more_horiz_outlined,
                      color: Colors.black,
                      size: 20.0,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: AutoCompleteSearchApp(),
                    ),
                    const SizedBox(height: 26),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              padding: EdgeInsets.all(16.0),
                              child: Text('ciao, NEGRO'),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: ExpansionTile(
                                minTileHeight: 85,
                                collapsedBackgroundColor: Colors.transparent,
                                shape: Border.all(
                                    color: Colors.transparent
                                ),
                                title: Text(
                                  'Brilliant Stars',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(16.0),
                                        bottomRight: Radius.circular(16.0),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 0.5,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Divider(
                                          color: Colors.grey,
                                          height: 1.0,
                                          thickness: 0.3,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 16),
                                              const Row(
                                                children: [
                                                  Text(
                                                    'Collection',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              LinearProgressIndicator(
                                                value: 0.25,
                                                backgroundColor: Colors.grey[300],
                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                                              ),
                                              SizedBox(height: 16),
                                              const Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          '25%',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Text(
                                                          '3 - 230 cards',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.orange,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          'Total value',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Text(
                                                          '\$1,329.18',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.green,
                                                          ),
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
                                          thickness: 0.3,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(width * 0.020),
                                          child: GridView.builder(
                                            shrinkWrap: true, // Allows GridView to fit the content
                                            physics: const NeverScrollableScrollPhysics(), // Disable GridView scrolling
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3, // Number of columns
                                              crossAxisSpacing: 0.018 * MediaQuery.of(context).size.width, // Horizontal spacing between cards
                                              mainAxisSpacing: 0.018 * MediaQuery.of(context).size.width, // Vertical spacing between cards
                                              childAspectRatio: 0.49,
                                            ),
                                            itemCount: 9, // Total number of cards
                                            itemBuilder: (context, index) {
                                              return CardItem(); // Use the CardItem widget for each card
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
                  ],
                ),
              ),
            ),
          ),
          const BottomWidget(), // The BottomWidget will always stay at the bottom
        ],
      ),
    );
  }
}

