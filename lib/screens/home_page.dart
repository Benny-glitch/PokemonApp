import 'package:flutter/material.dart';
import 'package:pokemon_card_collector/widgets/home_page/bottom_fixed_widget.dart';
import 'package:pokemon_card_collector/widgets/home_page/card_collection_container.dart';
import 'package:pokemon_card_collector/widgets/home_page/draggable_sheet.dart';
import 'package:pokemon_card_collector/widgets/home_page/carousel_notice.dart';

import 'create_collection_form.dart';  // Importa il form

class HomePage extends StatefulWidget {
  final DraggableScrollableController sheetController =
  DraggableScrollableController();

  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isFormVisible = false;  // Stato per gestire la visibilità del form

  void _toggleFormVisibility() {
    setState(() {
      _isFormVisible = !_isFormVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          // Il contenuto della pagina
          Padding(
            padding: const EdgeInsets.only(
              top: 12,
            ),
            child: CarouselNotice(),
          ),
          const MyDraggableSheet(
            child: Column(
              children: [
                CardCollectionContainer(totCost: 250.12),
                CardCollectionContainer(totCost: 250.12),
                CardCollectionContainer(totCost: 250.12),
                CardCollectionContainer(totCost: 250.12),
                CardCollectionContainer(totCost: 250.12),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomFixedWidget(onCreateCollectionTap: _toggleFormVisibility),
          ),

          // Mostra il form solo se _isFormVisible è true
          if (_isFormVisible)
            CreateCollectionForm(
              onClose: _toggleFormVisibility,  // Chiude il form
            ),
        ],
      ),
    );
  }
}
