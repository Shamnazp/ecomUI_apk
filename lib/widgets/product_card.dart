import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = constraints.maxHeight;

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductDetailScreen.routeName,
              arguments: product,
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cardWidth * 0.05),
            ),
            elevation: 3,
            child: Stack(
              children: [
                // Product content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(cardWidth * 0.05),
                      ),
                      child: Image.asset(
                        product.imageUrl,
                        height: cardHeight * 0.6,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: cardHeight * 0.03),
                    // Title
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: cardWidth * 0.05,
                      ),
                      child: Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: cardWidth * 0.08,
                        ),
                      ),
                    ),
                    SizedBox(height: cardHeight * 0.01),
                    // Price
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: cardWidth * 0.05,
                      ),
                      child: Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: cardWidth * 0.07,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),

                // Cart icon
                Positioned(
                  bottom: cardHeight * 0.05,
                  right: cardWidth * 0.05,
                  child: Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: const Color.fromARGB(221, 56, 55, 55),
                        size: cardWidth * 0.15,
                      ),
                      onPressed: () {
                        cart.addItem(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.title} added to cart'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
