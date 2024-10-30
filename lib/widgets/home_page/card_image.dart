import 'package:flutter/material.dart';
import 'package:pokemon_card_collector/models/card.dart';

class CardImage extends StatelessWidget {
  final PokemonCard card;
  final int count;

  const CardImage({
    required this.card,
    required this.count,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              card.images?.large ?? '',  // Usa l'URL dell'immagine grande o un valore di default
              width: width * 0.45,
              height: width * 0.6, // Regola l'altezza per mantenere le proporzioni
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Text(
                  'Image not available',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 4.0,
            right: 4.0,
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '$count',  // Mostra il numero di copie della carta
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
