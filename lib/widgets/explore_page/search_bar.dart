import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../models/card.dart';
import '../../screens/card_detail_page.dart';
import '../../services/card_service.dart';

class AutoCompleteSearchWidgetExplorePage extends StatefulWidget {
  final double appBarHeight;
  final double height;
  final List<String> selectedSetName;
  final RangeValues rangeValues;
  final List<String> selectedTypes;

  const AutoCompleteSearchWidgetExplorePage(
      {Key? key,
      required this.appBarHeight,
      required this.height,
      required this.rangeValues,
      required this.selectedSetName,
      required this.selectedTypes})
      : super(key: key);

  @override
  _AutoCompleteSearchWidgetStateExplorePage createState() =>
      _AutoCompleteSearchWidgetStateExplorePage();
}

class _AutoCompleteSearchWidgetStateExplorePage
    extends State<AutoCompleteSearchWidgetExplorePage> {
  bool _showBackArrow = false;
  final TextEditingController _controller = TextEditingController();
  late CardService _cardService;
  List<PokemonCard> _suggestions = [];
  Timer? _debounce;
  bool _isSuggestionSelected = false;
  bool _showCancelButton = false;
  StreamSubscription<List<PokemonCard>>? _subscription;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
    _cardService = Provider.of<CardService>(context, listen: false);
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
      _showBackArrow = _controller.text.isNotEmpty;
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
        _subscription = _cardService.searchCards(pattern, widget.rangeValues, widget.selectedTypes, widget.selectedSetName).listen((cards) {
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

    Future.delayed(const Duration(milliseconds: 100), () {
      _controller.addListener(_onSearchChanged);
      _isSuggestionSelected = false;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CardDetailPage(card: card),
        ),
      );
    });
  }

  void _clearSearch() {
    setState(() {
      _controller.clear();
      _suggestions = [];
      _showCancelButton = false;
      _showBackArrow = false;
    });
    _subscription?.cancel();
  }

  Future<void> _openCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      final inputImage = InputImage.fromFilePath(photo.path);
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);

      try {
        final RecognizedText recognizedText =
            await textRecognizer.processImage(inputImage);
        _showTextOverlay(recognizedText);
      } catch (e) {
        print("Errore durante il riconoscimento del testo: $e");
      } finally {
        textRecognizer.close();
      }
    }
  }

  Future<void> _showTextOverlay(RecognizedText recognizedText) async {
    // Ottieni tutto il testo e separa le parole
    String fullText = recognizedText.blocks.map((block) => block.text).join(" ");
    List<String> selectedWords = []; // Traccia delle parole selezionate

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Testo Riconosciuto"),
              content: SingleChildScrollView(
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: fullText.split(' ').map((word) {
                    bool isSelected = selectedWords.contains(word);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          // Seleziona o deseleziona la parola
                          if (isSelected) {
                            selectedWords.remove(word);
                          } else {
                            selectedWords.add(word);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          word,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Chiudi"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      // Imposta il testo del campo di ricerca con le parole selezionate
                      _controller.text = selectedWords.join(' ');
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("Usa Testo"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const double searchBarHeight = 60.0;

    return SingleChildScrollView(
      child: Column(
        children: [
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13.0, vertical: 4.5),
                    child: Row(
                      children: [
                        if (_showBackArrow)
                          IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        else
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
                        IconButton(
                          icon:
                              const Icon(Icons.camera_alt, color: Colors.white),
                          onPressed: _openCamera,
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
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _suggestions.isEmpty
                ? 0
                : MediaQuery.of(context).size.height -
                    searchBarHeight -
                    widget.height -
                    widget.appBarHeight,
            curve: Curves.easeInOut,
            child: ListView.builder(
              physics: _suggestions.isEmpty
                  ? const NeverScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics(),
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                final card = _suggestions[index];
                return GestureDetector(
                  onTap: () => _onSuggestionSelected(card),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
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
