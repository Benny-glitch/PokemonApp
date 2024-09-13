import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouselNotice extends StatelessWidget {
  const CarouselNotice({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return CarouselSlider(
      options: CarouselOptions(
        height: 0.25 * height,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 21 / 9,
        viewportFraction: 0.8,
      ),
      items: [
        _buildCarouselItem(
          title: 'New Collection: VMAX Rising',
          description:
          'Discover the new VMAX Rising collection with amazing new Pokémon cards!',
          backgroundColor: Colors.orangeAccent,
        ),
        _buildCarouselItem(
          title: 'Shiny Legends Expansion',
          description:
          'Get your hands on the latest Shiny Legends expansion with exclusive cards!',
          backgroundColor: Colors.blueAccent,
        ),
        _buildCarouselItem(
          title: 'Classic Cards Reissue',
          description:
          'Revisit classic Pokémon cards with our special reissue collection!',
          backgroundColor: Colors.purpleAccent,
        ),
      ],
    );
  }

  Widget _buildCarouselItem({
    required String title,
    required String description,
    required Color backgroundColor,
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
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
