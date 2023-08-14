import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


class MyAppState extends ChangeNotifier {
  var streamers = {};
  var current = WordPair.random();
  // var current = "testing"

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
   var favorites = <WordPair>[];

  void addStreamer(){
    notifyListeners();
  }
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}