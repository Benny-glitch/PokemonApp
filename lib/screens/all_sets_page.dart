import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pokemon_card_collector/models/set.dart';
import 'package:pokemon_card_collector/services/sets_services.dart';
import 'package:provider/provider.dart';

class AllSetsPage extends StatefulWidget {
  final List<String>? initiallySelectedSets;

  const AllSetsPage({Key? key, required this.initiallySelectedSets}) : super(key: key);

  @override
  _AllSetsPageState createState() => _AllSetsPageState();
}

class _AllSetsPageState extends State<AllSetsPage> {
  final TextEditingController _searchController = TextEditingController();
  String? searchQuery;
  Timer? _debounce;
  List<String> selectedSets = [];

  @override
  void initState() {
    super.initState();
    if (widget.initiallySelectedSets != null) {
      selectedSets.addAll(widget.initiallySelectedSets!);
    }
    _searchController.addListener(_onSearchChanged);
  }

  void _onSetToggled(String? setName, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedSets.add(setName!);
      } else {
        selectedSets.remove(setName);
      }
    });
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        searchQuery = _searchController.text;
      });
    });
  }

  void _onConfirmSelection() {
    Navigator.pop(context, selectedSets.toList());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SetsServices setsService = Provider.of<SetsServices>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sets', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.white),
            onPressed: _onConfirmSelection,
            tooltip: 'Confirm Selection',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Name of the set',
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey.shade900,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: StreamBuilder<List<PokemonCardSet>>(
                stream: setsService.searchSet(searchQuery ?? ''),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No sets found.',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    // Dividi i set in selezionati e non selezionati
                    final allSets = snapshot.data!;
                    final selected = allSets.where((set) => selectedSets.contains(set.name)).toList();
                    final unselected = allSets.where((set) => !selectedSets.contains(set.name)).toList();

                    // Unisci le liste con i selezionati in cima
                    final sortedSets = [...selected, ...unselected];

                    return ListView.builder(
                      itemCount: sortedSets.length,
                      itemBuilder: (context, index) {
                        final set = sortedSets[index];
                        final isSelected = selectedSets.contains(set.name);
                        return GestureDetector(
                          onTap: () => _onSetToggled(set.name, !isSelected),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.network(
                                      set.images?.logo ?? 'https://via.placeholder.com/150',
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                        size: 48,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12.0),
                                  Expanded(
                                    child: Text(
                                      set.name ?? 'Unknown Set',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: isSelected,
                                    onChanged: (bool? value) {
                                      if (value != null) {
                                        _onSetToggled(set.name, value);
                                      }
                                    },
                                    activeColor: Colors.blue,
                                    checkColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
