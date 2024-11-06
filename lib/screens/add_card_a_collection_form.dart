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
  bool _isFormVisible = false;


  @override
  void initState() {
    super.initState();
    hiveService = Provider.of<HiveService>(context, listen: false);
    _openBox();
  }

  void _toggleFormVisibility() {
    setState(() {
      _isFormVisible = !_isFormVisible;
    });
  }

  Future<void> _openBox() async {
    try {
      _collectionBox = hiveService.getAllCollections();
      for (int index = 0; index < _collectionBox.length; index++) {
        _selectedCollections[index] = false;
      }
    } catch (error) {
      showToast("Error loading data.");
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

  void _addNewCollection(String name, String description) async {
    try {
      final newCollection =
      CardCollection(name: name, description: description, totCost: 0);
      await hiveService.addCollection(newCollection);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.up,
          duration: const Duration(milliseconds: 1000),
          backgroundColor: Colors.grey,
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 100,
              left: 10,
              right: 10
          ),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Collection name is already used',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      );
    }
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
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade50,
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {
                              },
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.folder, color: Colors.orange),
                                  Text(
                                    "Create new collection",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Icon(Icons.add, color: Colors.black),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              child: _buildCollectionList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade50,
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: _saveSelectedCollections,
                              child: const Text("Save Card",
                                  style: TextStyle(color: Colors.black)),
                            ),
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
      return const Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text("No collections available"),
        ),
      );
    }
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        itemCount: _collectionBox.length,
        itemBuilder: (context, index) {
          final collection = _collectionBox[index];
          return CheckboxListTile(
            title: Text(collection.name, style: TextStyle(fontSize: 20)),
            subtitle: Text('${collection.cards.length}',
                style: TextStyle(fontSize: 16)),
            value: _selectedCollections[index],
            onChanged: (bool? value) {
              setState(() {
                _selectedCollections[index] = value ?? false;
              });
            },
            controlAffinity:
                ListTileControlAffinity.leading,
          );
        },
      ),
    );
  }

  void _saveSelectedCollections() {
    final selectedIndexes = _selectedCollections.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (selectedIndexes.isNotEmpty) {
      for (var index in selectedIndexes) {
        hiveService.addCardToCollection(index, widget.card);
      }

      showToast("Card saved to selected collections!");
      widget.onClose();
    } else {
      showToast("Please select at least one collection.");
    }
  }
}
