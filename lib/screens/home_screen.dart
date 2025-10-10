import 'package:ecom_apk/widgets/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart' hide Category;
import '../widgets/product_card.dart';
import '../providers/cart_provider.dart';
import 'bag_screen.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _bannerTimer;

  final List<Product> products = [
    Product(
      id: 'p1',
      title: 'Basics',
      description: 'Urban hug oversized',
      price: 115.0,
      imageUrl: 'assets/dress1.jpg',
      colors: ['#FFC0CB', '#000000'],
    ),
    Product(
      id: 'p2',
      title: 'New balance',
      description: 'New balance FuelCell Rebel v3',
      price: 250.0,
      imageUrl: 'assets/shoe1.jpg',
      colors: ['#0000FF', '#FFFFFF'],
    ),
  ];

  final List<String> banners = ['assets/banner.jpg', 'assets/bannerr.png'];

  //categories sec
  final List<Category> categories = [
    Category(name: 'T-Shirt', icon: 'assets/category-tshirt.jpg'),
    Category(name: 'Sports', icon: 'assets/category-sport.jpg'),
    Category(name: 'Hoodies', icon: 'assets/category-hoodies.jpg'),
    Category(name: 'Pants', icon: 'assets/category-pants.jpg'),
    Category(name: 'Shorts', icon: 'assets/category-shorts.jpg'),
  ];

  PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });

    // auto scroll
    _bannerTimer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < banners.length - 1) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _bannerTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.04),

                // Search bar + cart
                Row(
                  children: [
                    Container(
                      height: screenHeight * 0.06,
                      width: screenWidth * 0.72,
                      margin: EdgeInsets.only(left: screenWidth * 0.03),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for products',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Stack(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.shopping_cart,
                            size: screenHeight * 0.035,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, CartScreen.routeName);
                          },
                        ),
                        if (cart.items.isNotEmpty)
                          Positioned(
                            right: 4,
                            top: 4,
                            child: CircleAvatar(
                              radius: screenHeight * 0.015,
                              backgroundColor: Colors.red,
                              child: Text(
                                cart.items.length.toString(),
                                style: TextStyle(
                                  fontSize: screenHeight * 0.012,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),

                // Banner Section
                Column(
                  children: [
                    Container(
                      height: screenHeight * 0.25,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: banners.length,
                        itemBuilder: (ctx, i) => Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(banners[i]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.01),

                    // Indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(banners.length, (index) {
                        bool isActive = _currentPage == index;
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          width: isActive ? 12 : 8,
                          height: isActive ? 12 : 8,
                          decoration: BoxDecoration(
                            color: isActive ? Colors.black : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.02),

                // Categories Horizontal List
                CategoryWidget(categories: categories),
                SizedBox(height: screenHeight * 0.00),

                // Explore Section title
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                    horizontal: screenWidth * 0.02,
                  ),

                  child: Text(
                    'Explore.',
                    style: TextStyle(
                      fontSize: screenHeight * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Products Grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 3 / 4,
                        crossAxisSpacing: screenWidth * 0.03,
                        mainAxisSpacing: screenHeight * 0.02,
                      ),
                      itemBuilder: (ctx, i) =>
                          ProductCard(product: products[i]),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
