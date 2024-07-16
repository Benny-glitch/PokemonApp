import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomFixedWidget extends StatelessWidget {
  const BottomFixedWidget({super.key});
  static const double height = 120.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            children: [
              Icon(Icons.folder, color: Colors.orange),
              SizedBox(width: 8),
              Text('Create new collection'),
              Spacer(),
              Icon(Icons.add, color: Colors.orange),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text('Explore'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Collection'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}