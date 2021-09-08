import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:georline_shopping_app/models/http_exception.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    final String endPoint =
        'https://georline-shopping-flutter-test-default-rtdb.firebaseio.com';
    final String productsCollection =
        '/products/$id.json'; // .json for Firebase
    final url = Uri.parse('$endPoint/$productsCollection');
    final bool tempFavorite = isFavorite;
    this.isFavorite = !this.isFavorite;
    notifyListeners();
    try {
      var response =
          await http.patch(url, body: json.encode({'isFavorite': isFavorite}));
      if (response.statusCode >= 400) {
        this.isFavorite = tempFavorite;
        throw HttpException(
            'Something went wrong trying to vaforite this product. Try again');
      }
    } catch (e) {
      this.isFavorite = tempFavorite;
      notifyListeners();
      throw e;
    }
  }
}
