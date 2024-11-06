import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/set.dart';
import '../../services/sets_services.dart';

class CarouselNotice extends StatelessWidget {

  const CarouselNotice({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final SetsServices setsService = Provider.of<SetsServices>(context, listen: false);

    return StreamBuilder<List<PokemonCardSet>>(
      stream: setsService.newestSets(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
          return  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'No top cards available.',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        }
        final sets = snapshot.data!;
        return CarouselSlider(
          options: CarouselOptions(
            height: 0.25 * height,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 21 / 9,
            viewportFraction: 0.8,
          ),
          items: sets.map((set) => _buildCarouselItem(
            title: set.name,
            description: 'Release Date: ${set.releaseDate}',
            backgroundColor: Colors.grey.shade200,
            logoUrl: set.images?.logo,
          )).toList(),
        );
      },
    );
  }

  Widget _buildCarouselItem({
    required String? title,
    required String? description,
    required Color backgroundColor,
    required String? logoUrl,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (logoUrl != null && logoUrl.isNotEmpty)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(
                      logoUrl,
                      height: 70,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      title ?? 'Untitled Set',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      description ?? '',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
