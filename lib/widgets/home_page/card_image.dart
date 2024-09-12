import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  final String imageUrl;
  final int count;

  const CardImage({required this.imageUrl, required this.count, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: 90.0,
              height: 120.0,
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
                '$count',
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