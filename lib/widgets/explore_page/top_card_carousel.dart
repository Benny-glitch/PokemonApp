import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_card_collector/screens/card_detail_page.dart';
import 'package:provider/provider.dart';
import '../../models/card.dart';
import '../../services/card_service.dart';

class TopCardsCarousel extends StatelessWidget {
  final VoidCallback onRefresh;

  const TopCardsCarousel({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final CardService cardService = Provider.of<CardService>(context);
    return StreamBuilder<List<PokemonCard>>(
      stream: cardService.getTopValuedCards(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 120,
                ),
                SizedBox(height: 10),
                Text(
                  'An internet error as occurred. Please try again.',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No top cards available.',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        } else {
          final topCards = snapshot.data!;
          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.4,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  enlargeCenterPage: true,
                ),
                items: topCards.map((card) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CardDetailPage(
                                card: card,
                              ),
                            ),
                          );
                        },
                        child: AspectRatio(
                          aspectRatio: 3.5 / 3,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            color: Colors.grey.shade900,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: AspectRatio(
                                    aspectRatio: 2 / 3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.network(
                                        card.images?.large ??
                                            'https://via.placeholder.com/150',
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error,
                                            stackTrace) =>
                                        const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: 48,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    card.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
            ],
          );
        }
      },
    );
  }
}
