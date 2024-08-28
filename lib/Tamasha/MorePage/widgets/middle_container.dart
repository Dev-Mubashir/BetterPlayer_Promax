import 'package:flutter/material.dart';

class MiddleContainer extends StatelessWidget {
  const MiddleContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          color: Colors.blueGrey[900],
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.text_fields_sharp, color: Colors.white, size: 40),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tamasha',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 120, 241),
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Not Subscribed',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
