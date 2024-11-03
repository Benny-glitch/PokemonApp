import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/card_collection.dart';

class AddCardACollectionForm extends StatefulWidget {
  final VoidCallback onClose;

  const AddCardACollectionForm({
    super.key,
    required this.onClose,
  });

  @override
  _AddCardACollectionFormState createState() => _AddCardACollectionFormState();
}

class _AddCardACollectionFormState extends State<AddCardACollectionForm> {
  late Box<CardCollection> _collectionBox;
  final Map<String, bool> _selectedCollections = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  Future<void> _openBox() async {
    try {
      _collectionBox = await Hive.openBox<CardCollection>('card_collections');
      _collectionBox.values.forEach((collection) {
        _selectedCollections[collection.name] = false;
      });
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
                    ? const Center(
                        child:
                            CircularProgressIndicator())
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
        final collection = _collectionBox.getAt(index);
        return CheckboxListTile(
          title: Text(collection!.name),
          subtitle: Text(collection.description),
          value: _selectedCollections[collection.name],
          onChanged: (bool? value) {
            setState(() {
              _selectedCollections[collection.name] = value ?? false;
            });
          },
        );
      },
    );
  }

  void _saveSelectedCollections() {
    final selectedNames = _selectedCollections.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (selectedNames.isNotEmpty) {
      showToast("Card saved to selected collections!");
    } else {
      showToast("Please select at least one collection.");
    }


  }
}
