import 'package:flutter/material.dart';
import '../../models/card.dart';

class CardDetailPage extends StatelessWidget {
  final PokemonCard card;

  const CardDetailPage({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    card.images?.large ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.error, color: Colors.red, size: 48),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              card.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              card.set?.name ?? 'Unknown Set',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            if (card.cardmarket?.prices?.averageSellPrice != null)
              Text(
                'Average Price: \$${card.cardmarket?.prices?.averageSellPrice}',
                style: const TextStyle(fontSize: 18, color: Colors.black87),
              ),
            const SizedBox(height: 16),
            Text(
              'ID: ${card.id}',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
