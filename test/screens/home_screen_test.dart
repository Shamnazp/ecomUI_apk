import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ecom_apk/screens/home_screen.dart';
import 'package:ecom_apk/providers/cart_provider.dart';

void main() {
  testWidgets('🏠 HomeScreen loads products', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
        child: MaterialApp(home: HomeScreen()),
      ),
    );

    // Check main heading or product list
    expect(find.textContaining('Chair'), findsWidgets);
  });
}
