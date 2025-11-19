import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,

        // Add toggle inside AppBar for clean UI
        actions: [
          Row(
            children: [
              Icon(
                themeProvider.isDark ? Icons.nightlight_round : Icons.wb_sunny,
                size: 22,
              ),
              Switch.adaptive(
                value: themeProvider.isDark,
                onChanged: (val) {
                  themeProvider.setDark(val);
                },
              ),
            ],
          ),
        ],
      ),
      // Body content
      body: Center(child: Text('Search Page', style: TextStyle(fontSize: 20))),
    );
  }
}
