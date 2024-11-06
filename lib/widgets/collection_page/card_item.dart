import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String imageUrl;
  final String cardType;
  final String cardName;
  final String price;
  final int? quantity;
  final AlignmentGeometry badgeAlignment;

  const CardItem({
    Key? key,
    required this.imageUrl,
    required this.cardType,
    required this.cardName,
    required this.price,
    required this.quantity,
    this.badgeAlignment = Alignment.topRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 0.7,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade50,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.018),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      imageUrl,
                      width: width * 0.45,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/placeholder.png',
                          width: width * 0.45,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: badgeAlignment,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '$quantity',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(width * 0.018, width * 0.009, width * 0.018, width * 0.018),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: width * 0.001),
                Text(
                  cardType,
                  style: TextStyle(
                    fontSize: width * 0.030,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: width * 0.001),
                Text(
                  cardName,
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: width * 0.03),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: width * 0.04,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
