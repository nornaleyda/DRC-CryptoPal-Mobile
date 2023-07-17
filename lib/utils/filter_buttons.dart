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
            onPressed: onLowestPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: const BorderSide(color: Color(0xFFBB0163)),
              ),
              backgroundColor: isDescending ? Color(0xFFBB0163) : Colors.white,
              foregroundColor: Color(0xFFBB0163),
            ),
            child: Text(
              'Highest',
              style: TextStyle(
                color: isDescending ? Colors.white : Color(0xFFBB0163),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: onHighestPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: const BorderSide(color: Color(0xFFBB0163)),
              ),
              backgroundColor: isDescending ? Colors.white : Color(0xFFBB0163),
              foregroundColor: Color(0xFFBB0163), 
            ),
            child: Text(
              'Lowest',
              style: TextStyle(
                color: isDescending ? Color(0xFFBB0163) : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
