// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/bottom_nav_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/bag_screen.dart';
import 'theme/theme.dart'; // lightTheme, darkTheme

void main() {
  runApp(ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SYNC',
            theme: lightTheme,
            darkTheme: DarkTheme,
            themeMode: themeProvider.themeMode, // drives whether light/dark used
            home: BottomNavScreen(),
            routes: {
              ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
              CartScreen.routeName: (_) => CartScreen(),
            },
          );
        },
      ),
    );
  }
}
