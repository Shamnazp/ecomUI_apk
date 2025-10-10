import 'package:flutter_test/flutter_test.dart';
import 'package:ecom_apk/providers/cart_provider.dart';
import 'package:ecom_apk/models/product.dart';

void main() {
  late CartProvider cart;
  late Product sampleProduct;

  setUp(() {
    cart = CartProvider();
    sampleProduct = Product(
      id: 'p1',
      title: 'Minimal Chair',
      description: 'Comfortable chair',
      price: 100.0,
      imageUrl: 'assets/test1.jpg',
      colors: ['#000000'],
    );
  });

  test('🧩 Add item to cart', () {
    cart.addItem(sampleProduct);
    expect(cart.items.length, 1);
  });

  test('🧩 Increase quantity if added twice', () {
    cart.addItem(sampleProduct);
    cart.addItem(sampleProduct);
    expect(cart.items[sampleProduct.id]!.quantity, 2);
  });

  test('🧩 Calculate total amount correctly', () {
    cart.addItem(sampleProduct);
    cart.addItem(sampleProduct);
    expect(cart.totalAmount, 200.0);
  });

  test('🧩 Remove item from cart', () {
    cart.addItem(sampleProduct);
    cart.removeItem(sampleProduct.id);
    expect(cart.items.isEmpty, true);
  });
}
