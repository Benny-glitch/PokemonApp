import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/card.dart';
import '../../services/card_service.dart';

class AutoCompleteSearchWidgetExplorePage extends StatefulWidget {
  final FocusNode focusNode;

  const AutoCompleteSearchWidgetExplorePage({Key? key, required this.focusNode})
      : super(key: key);

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
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: widget.focusNode,
                  controller: _controller,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search for a card',
                    hintStyle: const TextStyle(
                      color: Colors.white30,
                      fontWeight: FontWeight.w300,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade900,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(width: 10),
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
        const SizedBox(height: 10),
        if (_suggestions.isNotEmpty)
          Column(
            children: _suggestions
                .map((card) => ListTile(
                      title: Text(
                        card.name,
                        style: const TextStyle(color: Colors.black),
                      ),
                      onTap: () => _onSuggestionSelected(card),
                    ))
                .toList(),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
