import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/card.dart';
import '../../services/card_service.dart';

class AutoCompleteSearchWidget extends StatefulWidget {
  @override
  _AutoCompleteSearchWidgetState createState() =>
      _AutoCompleteSearchWidgetState();
}

class _AutoCompleteSearchWidgetState extends State<AutoCompleteSearchWidget> {
  final TextEditingController _controller = TextEditingController();
  final CardService _cardService = CardService();
  List<PokemonCard> _suggestions = [];
  Timer? _debounce;
  bool _isSuggestionSelected = false;
  StreamSubscription<List<PokemonCard>>? _subscription;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    _debounce?.cancel();
    _subscription?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_isSuggestionSelected) {
      return;
    }

    if (_controller.text.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      _debounce?.cancel();
      _subscription?.cancel();
      return;
    }

    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 300), () {
      final pattern = _controller.text;

      if (pattern.isNotEmpty) {
        _subscription?.cancel();

        final stream = _cardService.searchCards(pattern);

        _subscription = stream.listen((cards) {
          if (!_isSuggestionSelected) {
            setState(() {
              _suggestions = cards;
            });
          }
        });
      }
    });
  }

  void _onSuggestionSelected(PokemonCard card) {
    _isSuggestionSelected = true;

    _controller.removeListener(_onSearchChanged);

    _subscription?.cancel();

    setState(() {
      _controller.text = card.name;
      _suggestions = [];
    });

    Future.delayed(Duration(milliseconds: 100), () {
      _controller.addListener(_onSearchChanged);
      _isSuggestionSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Search for a card...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(
                  top: BorderSide(color: Colors.grey.shade100, width: 1.0),
                  bottom: BorderSide(color: Colors.grey.shade100, width: 1.0))),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            constraints: _suggestions.isEmpty
                ? BoxConstraints(maxHeight: 0)
                : BoxConstraints(maxHeight: 500),
            child: _suggestions.isEmpty
                ? SizedBox.shrink()
                : ListView.builder(
                    itemCount: _suggestions.length,
                    itemBuilder: (context, index) {
                      final card = _suggestions[index];
                      return GestureDetector(
                        onTap: () {
                          _onSuggestionSelected(card);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: AspectRatio(
                                      aspectRatio: 0.7,
                                      child: card.images!.small
                                              .toString()
                                              .isNotEmpty
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                card.images!.small.toString(),
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    color: Colors.grey[200],
                                                    child: Icon(
                                                      Icons.error,
                                                      color: Colors.red,
                                                      size: 48,
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : Container(
                                              color: Colors.grey[200],
                                              child: Icon(
                                                Icons.error,
                                                color: Colors.red,
                                                size: 48,
                                              ),
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 13,
                                  ),
                                  Expanded(
                                    flex: 5, // Spazio maggiore per i dettagli
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          card.name,
                                          style: TextStyle(
                                            fontSize: 20, // Nome più grande
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '${card.set?.name}',
                                          // Aggiungi collezione qui
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${card.id}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                card.cardmarket?.prices
                                                            ?.averageSellPrice !=
                                                        null
                                                    ? Text(
                                                        '${card.cardmarket?.prices?.averageSellPrice}',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                      )
                                                    : Icon(
                                                        Icons.error,
                                                        color: Colors.red,
                                                        size: 48,
                                                      ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
