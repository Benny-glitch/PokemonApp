import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/card.dart';
import '../../services/card_service.dart';

class AutoCompleteSearchWidget extends StatefulWidget {
  @override
  _AutoCompleteSearchWidgetState createState() => _AutoCompleteSearchWidgetState();
}

class _AutoCompleteSearchWidgetState extends State<AutoCompleteSearchWidget> {
  final TextEditingController _controller = TextEditingController();
  final CardService _cardService = CardService();
  List<PokemonCard> _suggestions = [];
  Timer? _debounce;
  bool _isSuggestionSelected = false;
  bool _showCancelButton = false;
  StreamSubscription<List<PokemonCard>>? _subscription;
  late CardService
      _cardService;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cardService = Provider.of<CardService>(context, listen: false);
    });
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

    setState(() {
      _showCancelButton = _controller.text.isNotEmpty;
    });

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
      _showCancelButton = false;
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      _controller.addListener(_onSearchChanged);
      _isSuggestionSelected = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _controller.clear();
      _suggestions = [];
      _showCancelButton = false;
    });
    _subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search any card...',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    filled: true,
                    fillColor: Colors.white60,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0), // Arrotonda i bordi
                      borderSide: BorderSide.none, // Rimuove il bordo esterno
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: Colors.grey.shade400), // Bordo mentre è inattivo
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), // Bordo mentre è attivo
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
              if (_showCancelButton)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextButton(
                    onPressed: _clearSearch,
                    child: const Text('Cancel',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Container(
          margin: _suggestions.isEmpty
              ? EdgeInsets.fromLTRB(0, 0, 0, 0)
              : EdgeInsets.fromLTRB(0, 25.0, 0, 0),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            border: Border(
              top: BorderSide(color: Colors.grey.shade200, width: 1.5),
              bottom: BorderSide(color: Colors.grey.shade200, width: 1.5),
            ),
          ),
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
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: AspectRatio(
                                      aspectRatio: 0.7,
                                      child: card.images?.small != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                card.images!.small!,
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
                                  SizedBox(width: 13),
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          card.name,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '${card.set?.name}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                        color: Colors.grey[600],
                                                      ),
                                                    )
                                                  : Icon(
                                                      Icons.error,
                                                      color: Colors.red,
                                                      size: 48,
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
