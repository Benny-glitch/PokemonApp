import 'package:flutter/material.dart';
import 'package:pokemon_card_collector/widgets/card_collection_container.dart';
import 'package:pokemon_card_collector/widgets/draggable_sheet.dart';

class HomePage extends StatelessWidget {
  final DraggableScrollableController sheetController =
  DraggableScrollableController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Text(
            'PokeDesk',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 28,
            ),
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: const MyDraggableSheet(
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Collection',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Icon(
                          Icons.ad_units,
                          color: Colors.pink,
                          size: 24.0,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                      ]
                    ),
                  ),
                ],
              ),
              Divider(thickness: 0.4,),
              CardCollectionContainer(totCost: 100.0,)
            ],
          )
      ),
    );
  }
}