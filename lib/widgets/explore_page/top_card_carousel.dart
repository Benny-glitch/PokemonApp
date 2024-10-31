import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/card.dart';
import '../../services/card_service.dart';

class TopCardsCarousel extends StatelessWidget {
  const TopCardsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final CardService cardService = Provider.of<CardService>(context);
    return StreamBuilder<List<PokemonCard>>(
      stream: cardService.getTopValuedCards(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No top cards available.'));
        } else {
          final topCards = snapshot.data!;
          return CarouselSlider(
            options: CarouselOptions(
              height: 550,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              enlargeCenterPage: true,
            ),
            items: topCards.map((card) {
              return Builder(
                builder: (BuildContext context) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: Colors.grey.shade900,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          card.images?.large ??
                              'https://via.placeholder.com/150',
                          height: 400,
                          width: 550,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          card.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          );
        }
      },
    );
  }
}
