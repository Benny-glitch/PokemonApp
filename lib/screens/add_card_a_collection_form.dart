import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../models/card.dart';
import '../models/card_collection.dart';
import '../services/hive_service.dart';

class AddCardACollectionForm extends StatefulWidget {
  final VoidCallback onClose;
  final PokemonCard card;

  const AddCardACollectionForm({
    super.key,
    required this.onClose,
    required this.card,
  });

  @override
  _AddCardACollectionFormState createState() => _AddCardACollectionFormState();
}

class _AddCardACollectionFormState extends State<AddCardACollectionForm> {
  late List<CardCollection> _collectionBox;
  final Map<int, bool> _selectedCollections = {};
  bool isLoading = true;
  late HiveService hiveService;

  @override
  void initState() {
    super.initState();
    hiveService = Provider.of<HiveService>(context, listen: false);
    _openBox();
  }

  Future<void> _openBox() async {
    try {
      _collectionBox = hiveService.getAllCollections();
      for (int index = 0; index < _collectionBox.length; index++) {
        _selectedCollections[index] = false;
      }
    } catch (error) {
      showToast("Errore durante il caricamento dei dati.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Positioned.fill(
      child: GestureDetector(
        onTap: widget.onClose,
        child: Container(
          color: Colors.black54,
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 0.7 * screenWidth,
                height: 0.5 * screenHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: const Text(
                              'Collection',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            height: 1.0,
                            thickness: 0.4,
                          ),
                          Expanded(
                            child: _buildCollectionList(),
                          ),
                          ElevatedButton(
                            onPressed: _saveSelectedCollections,
                            child: const Text("Save Card"),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCollectionList() {
    if (_collectionBox.isEmpty) {
      return const Center(child: Text("No collections available"));
    }
    return ListView.builder(
      itemCount: _collectionBox.length,
      itemBuilder: (context, index) {
        final collection = _collectionBox[index];
        return CheckboxListTile(
          title: Text(collection.name),
          subtitle: Text(collection.description),
          value: _selectedCollections[index],
          // Usa l'indice del Box come chiave
          onChanged: (bool? value) {
            setState(() {
              _selectedCollections[index] =
                  value ?? false; // Salva lo stato usando l'indice
            });
          },
        );
      },
    );
  }

  void _saveSelectedCollections() {
    final selectedIndexes = _selectedCollections.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (selectedIndexes.isNotEmpty) {
      for (var index in selectedIndexes) {
        CardCollection collection = _collectionBox[index];
        collection.totCost +=
            widget.card.cardmarket?.prices?.averageSellPrice ?? 0;
        hiveService.addCardToCollection(index, widget.card);
      }

      showToast("Card saved to selected collections!");
      widget.onClose();
    } else {
      showToast("Please select at least one collection.");
    }
  }
}
