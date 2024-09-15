import 'dart:async';
import 'package:flutter/material.dart';
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
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          constraints: _suggestions.isEmpty
              ? BoxConstraints(maxHeight: 0)
              : BoxConstraints(maxHeight: 200),
          child: _suggestions.isEmpty
              ? SizedBox.shrink()
              : ListView.builder(
            itemCount: _suggestions.length,
            itemBuilder: (context, index) {
              final card = _suggestions[index];
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      child:  card.images!.small.toString().isNotEmpty
                          ? Image.network(
                        card.images!.small.toString(),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 24,
                            ),
                          );
                        },
                      )
                          : Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 36,
                        ),
                      ),
                    ),
                    title: Text(card.name),
                    onTap: () => _onSuggestionSelected(card),
                  ),
                  SizedBox(height: 8),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
