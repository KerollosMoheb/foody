import 'package:flutter/material.dart';

class ToppingCard extends StatelessWidget {
  const ToppingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onAdd,
  });
  final String imageUrl;
  final String title;
  final VoidCallback onAdd;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Material(
        shadowColor: Colors.grey.shade500,
        borderRadius: BorderRadius.circular(24),
        elevation: 1,
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(24),
          child: Container(
            decoration: BoxDecoration(color: Colors.brown.shade800),
            height: 155,
            width: 130,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),

                  child: Image.asset(imageUrl, fit: BoxFit.cover),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: onAdd,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.red,
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
