import 'package:flutter/material.dart';
import 'package:nested_bottom_navigation_bar/enums/tab_item.dart';
import 'package:nested_bottom_navigation_bar/pages/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageTitle = TabItem.home.title;
    return Scaffold(
      appBar: AppBar(title: Text(pageTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(pageTitle),
            ElevatedButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const DetailPage(),
                  ),
                );
              },
              child: const Text('詳細ページへ'),
            ),
          ],
        ),
      ),
    );
  }
}
