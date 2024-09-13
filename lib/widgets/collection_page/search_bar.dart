import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/card.dart';
import '../../services/card_service.dart';

class AutoCompleteSearchApp extends StatefulWidget {
  @override
  _AutoCompleteSearchAppState createState() => _AutoCompleteSearchAppState();
}

class _AutoCompleteSearchAppState extends State<AutoCompleteSearchApp> {
  final TextEditingController _controller = TextEditingController();
  final CardService _cardService = CardService();
  Stream<List<PokemonCard>>? _cardStream;
  List<PokemonCard> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final pattern = _controller.text;
    if (pattern.isNotEmpty) {
      final stream = _cardService.searchCards(pattern);


      stream.listen((cards) {
        setState(() {
          _suggestions = cards;

        });
      });
    } else {
      setState(() {
        _suggestions = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Search for a card...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Stack(children: [
          Container(
            constraints: BoxConstraints(maxHeight: 200),
            child: _suggestions.isEmpty
                ? Center(
                    child: Text('No cards found'),
                  )
                : ListView.builder(
                    itemCount: _suggestions.length,
                    itemBuilder: (context, index) {
                      final card = _suggestions[index];
                      return ListTile(
                        title: Text(card.name),
                        onTap: () {
                          setState(() {
                            _controller.text = card
                                .name; // Aggiorna il campo di ricerca con il nome della carta selezionata
                            _suggestions =
                                []; // Cancella i suggerimenti dopo la selezione
                          });
                        },
                      );
                    },
                  ),
          ),
        ]),
      ],
    );
  }
}
