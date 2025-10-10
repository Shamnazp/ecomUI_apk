import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ecom_apk/screens/bag_screen.dart';
import 'package:ecom_apk/models/product.dart';
import 'package:ecom_apk/providers/cart_provider.dart';

void main() {
  testWidgets('🛒 CartScreen shows added items', (WidgetTester tester) async {
    final cart = CartProvider();
    final product = Product(
      id: 'p1',
      title: 'Minimal Chair',
      description: 'Comfortable chair',
      price: 100.0,
      imageUrl: 'assets/test.jpg',
      colors: ['#000000'],
    );

    cart.addItem(product);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: cart,
        child: MaterialApp(home: CartScreen()),
      ),
    );

    expect(find.text('Minimal Chair'), findsOneWidget);
    expect(find.textContaining('₹100'), findsOneWidget);
  });
}
