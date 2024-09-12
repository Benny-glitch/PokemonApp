import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../models/card.dart';
import '../../services/card_service.dart';

class AutoCompleteSearchApp extends StatefulWidget {
  @override
  _AutoCompleteSearchAppState createState() => _AutoCompleteSearchAppState();
}

class _AutoCompleteSearchAppState extends State<AutoCompleteSearchApp> {
  final TextEditingController _controller = TextEditingController();
  final CardService _cardService = CardService();
  Timer? _debounce;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<PokemonCard?>(

      textFieldConfiguration: TextFieldConfiguration(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Search for a card...',
        ),
      ),
      suggestionsCallback: (pattern) async {
        if (pattern.isEmpty) {
          return [];
        }

        setState(() {
          _isLoading = true;
        });

        if (_debounce?.isActive ?? false) {
          _debounce?.cancel();
        }

        final completer = Completer<Iterable<PokemonCard?>>();

        _debounce = Timer(const Duration(milliseconds: 0), () async {
          List<PokemonCard>? cards = await _cardService.searchCards(pattern);

          setState(() {
            _isLoading = false;
          });

          completer.complete(cards);
        });
        return completer.future;
      },
      itemBuilder: (context, PokemonCard? suggestion) {
        if (suggestion == null) {
          return const SizedBox();
        }
        return ListTile(
          title: Text(suggestion.name),
        );
      },
      noItemsFoundBuilder: (context) {
        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return const ListTile(
          title: Text('Nessuna carta trovata'),
        );
      },
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        elevation: 4.0,
      ),
      onSuggestionSelected: (PokemonCard? suggestion) {
        if (suggestion != null) {
          _controller.text = suggestion.name;
        }
      },
    );
  }
}
