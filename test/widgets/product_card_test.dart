import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ecom_apk/widgets/product_card.dart';
import 'package:ecom_apk/models/product.dart';
import 'package:ecom_apk/providers/cart_provider.dart';

void main() {
  testWidgets('🪑 ProductCard UI renders & adds to cart', (WidgetTester tester) async {
    final product = Product(
      id: 'p1',
      title: 'Minimal Chair',
      description: 'Comfortable chair',
      price: 100.0,
      imageUrl: 'assets/test.jpg',
      colors: ['#000000'],
    );

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
        child: MaterialApp(
          home: Scaffold(body: ProductCard(product: product)),
        ),
      ),
    );

    // Check if product info visible
    expect(find.text('Minimal Chair'), findsOneWidget);
    expect(find.text('\$100.00'), findsOneWidget);

    // Simulate tap on cart icon
    await tester.tap(find.byIcon(Icons.shopping_cart_outlined));
    await tester.pump();

    // Snackbar shown?
    expect(find.textContaining('added to cart'), findsOneWidget);
  });
}
