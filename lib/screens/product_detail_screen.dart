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
            'assets/dresscard1.jpg',
            'assets/shoecard3.jpg',
            'assets/shoecard4.jpg',
            'assets/shoecard5.jpg',
          ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main product image - full width
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.5,
                child: Image.asset(selectedImage, fit: BoxFit.cover),
              ),

              SizedBox(height: screenHeight * 0.015),

              // Category
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Text(
                  product.id == 'p1' ? "Category: Dress" : "Category: Shoes",
                  style: TextStyle(
                    fontSize: screenHeight * 0.015,
                    color: Colors.grey,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.005),

              // Product Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Text(
                  product.title,
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.006),

              // Description + rating
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${product.description}\n\nLorem fdhshfudhfouasf oh fshu gauag hasg hsdg hfa8 fg h8ofgdo ofig hfgog h fh 8fad hof ofa haf ofadhfhd hgfgfh ghfd8f ipsum is simply dummy fsdhhfdshusdfliuflnfdslnfds  gfuSDhilfdSDUHusdfgf sF oS GSFHouis hos Gohs O SF sFbfuSGRH u sdh8ors oSRG Hou8uSF o87SEG chggfsdygusdkyuSDGSDGVB SDFGHKSvyuFGHG FJHB TYFVHG ,jbsdfbytFGBMNd fjkhfbtyiAVBNB,A bytas ,as kuybsa ,dAHYBygbsa ,BSDTYGASDK SAM,BSAUGBDSK ada,mjbADKUYB  o8SGohsR o87SRG HoS hG P g8Oy SGRp9 8G 98...",
                        style: TextStyle(
                          fontSize: screenHeight * 0.018,
                          color: const Color.fromARGB(255, 99, 96, 96),
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Transform.translate(
                      offset: Offset(0, -screenHeight * 0.05), // move up safely
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: screenHeight * 0.028,
              
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Text(
                            "4.8",
                            style: TextStyle(
                              fontSize: screenHeight * 0.017,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Footer: price + add to cart
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
                    // Price
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
                            fontSize: screenHeight * 0.018,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    // Add to Cart button
                    SizedBox(
                      width: screenWidth * 0.45,
                      height: screenHeight * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          cart.addItem(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.title} added to cart'),
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
