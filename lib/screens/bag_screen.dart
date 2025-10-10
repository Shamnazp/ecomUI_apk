import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BAG',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Cart Items
            Expanded(
              child: ListView.separated(
                itemCount: cart.items.length,
                separatorBuilder: (ctx, i) =>
                    Divider(thickness: 1, color: Colors.grey.withOpacity(0.3)),
                itemBuilder: (ctx, i) {
                  final cartItem = cart.items.values.toList()[i];
                  final screenHeight = MediaQuery.of(context).size.height;
                  final screenWidth = MediaQuery.of(context).size.width;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical:
                          screenHeight * 0.008, // slightly smaller padding
                      horizontal: screenWidth * 0.03,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image
                        Image.asset(
                          cartItem.product.imageUrl,
                          height: screenHeight * 0.10,
                          width: screenWidth * 0.25,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: screenWidth * 0.03),

                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Title + Delete
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      cartItem.product.title,
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.018,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    iconSize: screenHeight * 0.022,
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: const Color.fromARGB(
                                        255,
                                        160,
                                        153,
                                        153,
                                      ),
                                    ),
                                    onPressed: () {
                                      cart.removeItem(cartItem.product.id);
                                    },
                                  ),
                                ],
                              ),

                              // Size/Color + Quantity Row
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "S | Grey  QTY |",
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.016,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    icon: Icon(
                                      Icons.remove,
                                      size: screenHeight * 0.015,
                                    ),
                                    onPressed: () {
                                      if (cartItem.quantity > 1) {
                                        cart.changeQuantity(
                                          cartItem.product.id,
                                          cartItem.quantity - 1,
                                        );
                                      }
                                    },
                                  ),
                                  Text(
                                    cartItem.quantity.toString(),
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.017,
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    icon: Icon(
                                      Icons.add,
                                      size: screenHeight * 0.015,
                                    ),
                                    onPressed: () {
                                      cart.changeQuantity(
                                        cartItem.product.id,
                                        cartItem.quantity + 1,
                                      );
                                    },
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: screenHeight * 0.010,
                              ), // smaller gap

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "MOVE TO WISHLIST",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: screenHeight * 0.014,
                                    ),
                                  ),
                                  Text(
                                    "₹${cartItem.product.price}",
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.0150,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Price Details + Address + Total
            Container(
              width: double.infinity,
              color: Colors.grey.shade100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // PRICE DETAILS
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.015,
                    ),
                    child: Center(
                      child: Text(
                        "PRICE DETAILS",
                        style: TextStyle(
                          fontSize: screenHeight * 0.022,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.withOpacity(0.3)),

                  // Delivering Address
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.015,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Delivering to Address",
                                style: TextStyle(
                                  fontSize: screenHeight * 0.018,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.005),
                              Text(
                                "BTM Layout, Bangalore",
                                style: TextStyle(
                                  fontSize: screenHeight * 0.016,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text(
                            "Change",
                            style: TextStyle(
                              fontSize: screenHeight * 0.016,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 1, color: Colors.grey.withOpacity(0.3)),

                  // Total Button
                  Padding(
                    padding: EdgeInsets.all(screenHeight * 0.02),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: Size(screenWidth, screenHeight * 0.06),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        "Total: \$${cart.totalAmount.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: screenHeight * 0.022,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
