import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late String selectedImage;
  String selectedSize = "M"; // default selected size

  @override
  void didChangeDependencies() {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    selectedImage = product.imageUrl;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final cart = Provider.of<CartProvider>(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Product-related images
    final relatedImages = product.id == 'p1'
        ? [
            'assets/dresscard1.jpg',
            'assets/dresscard2.jpg',
            'assets/dresscard3.jpg',
            'assets/dresscard4.jpg',
            'assets/dresscard5.jpg',
          ]
        : [
            'assets/shoe1.jpg',
            'assets/shoecard2.jpg',
            'assets/shoecard3.jpg',
            'assets/shoecard4.jpg',
            'assets/shoecard5.jpg',
          ];

    // Product description
    final productDescription = product.id == 'p1'
        ? "This minimal white t-shirt features a clean gradient finish that gives it a premium look. Perfect for everyday wear — soft, breathable fabric ensures all-day comfort while maintaining a stylish and versatile appearance."
        : "These vintage-style sneakers are a perfect blend of comfort and fashion. With their classic retro design, durable sole, and high-quality finish, they’re ideal for both casual and sporty looks. Great grip, lightweight feel — built for daily use.";

    // Color options
    final List<Color> colorOptions = product.id == 'p1'
        ? [
            Colors.white,
            Colors.grey.shade700,
            Colors.blueAccent,
          ] // T-shirt colors
        : [Colors.black, Colors.brown, Colors.redAccent]; // Shoe colors

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// MAIN PRODUCT IMAGE
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.5,
                child: Image.asset(selectedImage, fit: BoxFit.cover),
              ),

              SizedBox(height: screenHeight * 0.02),

              /// CATEGORY
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Text(
                  product.id == 'p1' ? "Category: T-Shirt" : "Category: Shoes",
                  style: TextStyle(
                    fontSize: screenHeight * 0.017,
                    color: Colors.grey,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.006),

              /// TITLE
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Text(
                  product.title,
                  style: TextStyle(
                    fontSize: screenHeight * 0.023,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              /// COLOR OPTIONS
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Row(
                  children: colorOptions
                      .map(
                        (color) => Container(
                          margin: EdgeInsets.only(right: screenWidth * 0.02),
                          width: screenHeight * 0.035,
                          height: screenHeight * 0.035,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black.withOpacity(0.1),
                              width: 1.5,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),

              SizedBox(height: screenHeight * 0.01),

              /// SIZE OPTIONS
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      "Select Size",
                      style: TextStyle(
                        fontSize: screenHeight * 0.020,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),

                    // Size buttons
                    Row(
                      children: ["S", "M", "L", "XL"]
                          .map(
                            (size) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = size;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: screenWidth * 0.025,
                                ),
                                width: screenHeight * 0.05,
                                height: screenHeight * 0.05,
                                decoration: BoxDecoration(
                                  color: selectedSize == size
                                      ? Colors.black
                                      : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    size,
                                    style: TextStyle(
                                      color: selectedSize == size
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: screenHeight * 0.018,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              /// DESCRIPTION + RATING
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        productDescription,
                        style: TextStyle(
                          fontSize: screenHeight * 0.018,
                          color: const Color.fromARGB(255, 99, 96, 96),
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.05),

                    /// RATING
                    Transform.translate(
                      offset: Offset(0, -screenHeight * 0.22), // move up safely
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: screenHeight * 0.035,
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Text(
                            "4.8",
                            style: TextStyle(
                              fontSize: screenHeight * 0.017,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              /// FOOTER: PRICE + ADD TO CART
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// PRICE
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Price",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: screenHeight * 0.018,
                          ),
                        ),
                        Text(
                          "\$${product.price.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: screenHeight * 0.022,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    /// ADD TO CART BUTTON
                    SizedBox(
                      width: screenWidth * 0.45,
                      height: screenHeight * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          cart.addItem(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.title} added to cart'),
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
