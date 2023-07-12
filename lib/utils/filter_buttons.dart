import 'package:flutter/material.dart';

class FilterButtons extends StatelessWidget {
  final bool isDescending;
  final VoidCallback onHighestPressed;
  final VoidCallback onLowestPressed;

  const FilterButtons({
    super.key,
    required this.isDescending,
    required this.onHighestPressed,
    required this.onLowestPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: onHighestPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isDescending ? const Color(0xFF979797) : Colors.pink,
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Lowest',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: onLowestPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isDescending ? Colors.pink : const Color(0xFF979797),
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Highest',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
