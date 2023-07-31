import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';
import '../utils/big_card.dart';
import '../state.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (WordPair favorite in appState.favorites) BigCard(pair: favorite),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
