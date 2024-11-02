import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/card.dart';
import '../../services/card_service.dart';

class AutoCompleteSearchWidgetExplorePage extends StatefulWidget {
  final double appBarHeight;
  final double height;

  const AutoCompleteSearchWidgetExplorePage({Key? key, required this.appBarHeight, required this.height}) : super(key: key);

  @override
  _AutoCompleteSearchWidgetStateExplorePage createState() =>
      _AutoCompleteSearchWidgetStateExplorePage();
}

class _AutoCompleteSearchWidgetStateExplorePage
    extends State<AutoCompleteSearchWidgetExplorePage> {
  final TextEditingController _controller = TextEditingController();
  final CardService _cardService = CardService();
  List<PokemonCard> _suggestions = [];
  Timer? _debounce;
  bool _isSuggestionSelected = false;
  bool _showCancelButton = false;
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
    if (_isSuggestionSelected) return;

    setState(() {
      _showCancelButton = _controller.text.isNotEmpty;
    });

    if (_controller.text.isEmpty) {
      setState(() => _suggestions = []);
      _debounce?.cancel();
      _subscription?.cancel();
      return;
    }

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final pattern = _controller.text;
      if (pattern.isNotEmpty) {
        _subscription?.cancel();
        _subscription = _cardService.searchCards(pattern).listen((cards) {
          if (!_isSuggestionSelected) {
            setState(() => _suggestions = cards);
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
    const double searchBarHeight = 60.0;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Search bar
          SizedBox(
            height: searchBarHeight,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Row(
                      children: [
                        const Icon(Icons.search_rounded, color: Colors.white),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Search for a card',
                              hintStyle: TextStyle(
                                color: Colors.white54,
                                fontWeight: FontWeight.w300,
                                fontSize: 18.0,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_showCancelButton)
                  TextButton(
                    onPressed: _clearSearch,
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Suggestions List
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _suggestions.isEmpty ? 0 : MediaQuery.of(context).size.height - searchBarHeight - widget.height - widget.appBarHeight,
            curve: Curves.easeInOut,
            child: ListView.builder(
              physics: _suggestions.isEmpty ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                final card = _suggestions[index];
                return GestureDetector(
                  onTap: () => _onSuggestionSelected(card),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: AspectRatio(
                                aspectRatio: 0.7,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    card.images?.small ?? '',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[200],
                                        child: const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: 48,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 13),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    card.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    card.set?.name ?? '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          card.id,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        card.cardmarket?.prices?.averageSellPrice != null
                                            ? Text(
                                          '${card.cardmarket?.prices?.averageSellPrice}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[600],
                                          ),
                                        )
                                            : const Icon(
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
        ],
      ),
    );
  }
}
