import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.fromLTRB(30.0, 16.0, 30.0, 13.0),
      decoration:  BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade50,
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              // Add the logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange.shade50,
              minimumSize: const Size.fromHeight(60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text(
              'Add cards',
              style: TextStyle(
                fontSize: 16,
                color: Colors.deepOrange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



