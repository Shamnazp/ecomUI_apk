import 'package:flutter/material.dart';

class Category {
  final String name;
  final String icon; // asset path

  Category({required this.name, required this.icon});
}

class CategoryWidget extends StatelessWidget {
  final List<Category> categories;

  const CategoryWidget({required this.categories, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.12, // reduced from 0.15
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (ctx, i) {
          final category = categories[i];
          return Container(
            width: screenWidth * 0.2, // slightly smaller width too
            margin: EdgeInsets.only(right: screenWidth * 0.03),
            child: Column(
              children: [
                // Full image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    category.icon,
                    height: screenHeight * 0.08, // reduced from 0.10
                    width: screenHeight * 0.08,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 4), // smaller spacing
                Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
