import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokemon_card_collector/screens/add_card_a_collection_form.dart';
import '../../models/card.dart';

class CardDetailPage extends StatefulWidget {
  final PokemonCard card;

  CardDetailPage({required this.card});

  @override
  _CardDetailPageState createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  bool isFavorite = false;
  Color dominantColor = Colors.black;
  bool isSheetDragged = false;
  final DraggableScrollableController _draggableController = DraggableScrollableController();

  final double initialChildSize = 0.45;

  @override
  void initState() {
    super.initState();
    _draggableController.addListener(_handleDraggableSheet);
    _updatePalette();
  }

  @override
  void dispose() {
    _draggableController.removeListener(_handleDraggableSheet);
    super.dispose();
  }

  Future<void> _updatePalette() async {
    if (widget.card.images?.large != null) {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(widget.card.images!.large!),
      );
      setState(() {
        dominantColor = paletteGenerator.dominantColor?.color ?? Colors.black;
      });
    }
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void _handleDraggableSheet() {
    setState(() {
      isSheetDragged = _draggableController.size > initialChildSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    final double notifyBar = MediaQuery.of(context).viewPadding.top;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: dominantColor,
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: screenHeight * 0.1,
        title: Text(
          widget.card.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: screenWidth * 0.065,
            color: Colors.grey.shade200,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.grey.shade600,
              size: screenWidth * 0.075,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.0, -0.35),
                radius: 0.7,
                colors: [
                  dominantColor,
                  Colors.black,
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50 + notifyBar + appBarHeight),
              AspectRatio(
                aspectRatio: 5 / 3,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.network(
                    widget.card.images?.large ?? '',
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 48,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      widget.card.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.card.set?.name ?? 'Unknown Set',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    if (widget.card.cardmarket?.prices?.averageSellPrice != null)
                      Text(
                        'Average Price: \$${widget.card.cardmarket?.prices?.averageSellPrice}',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: initialChildSize,
            minChildSize: 0.45,
            maxChildSize: 0.65,
            controller: _draggableController,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: isSheetDragged ? Colors.black.withOpacity(0.5) : Colors.transparent,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.08),
                    child: DefaultTabController(
                      length: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabBar(
                            tabAlignment: TabAlignment.start,
                            isScrollable: true,
                            indicatorColor: Colors.white,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.grey,
                            dividerColor: Colors.transparent,
                            tabs: [
                              Tab(text: "Dettagli"),
                              Tab(text: "Statistiche"),
                              Tab(text: "Immagini 1"),
                              Tab(text: "Immagini 2"),
                              Tab(text: "Immagini 3"),
                              Tab(text: "Immagini 4"),
                            ],
                          ),
                          Container(
                            height: screenHeight * 0.4,
                            child: TabBarView(
                              children: [
                                Center(child: Text('Dettagli', style: TextStyle(color: Colors.white))),
                                Center(child: Text('Statistiche', style: TextStyle(color: Colors.white))),
                                Center(child: Text('Immagini 1', style: TextStyle(color: Colors.white))),
                                Center(child: Text('Immagini 2', style: TextStyle(color: Colors.white))),
                                Center(child: Text('Immagini 3', style: TextStyle(color: Colors.white))),
                                Center(child: Text('Immagini 4', style: TextStyle(color: Colors.white))),
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
          if (isFavorite)
            AddCardACollectionForm(
              onClose: _toggleFavorite,
              card: widget.card,
            ),
        ],
      ),
    );
  }
}
