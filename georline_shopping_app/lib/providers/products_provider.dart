import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:georline_shopping_app/providers/product.dart';

class ProductsProvider with ChangeNotifier {
  // Add _ so that the field can only be changed in this class
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      isFavorite: false,
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
      isFavorite: false,
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
      isFavorite: false,
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
      isFavorite: false,
    ),
  ];

  final String endPoint =
      'https://georline-shopping-flutter-test-default-rtdb.firebaseio.com';

  // var _showFavoritesOnly = false;

  // We will return a copy of the items
  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((p) => p.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((p) => p.isFavorite).toList();
  }

  // showFavorittesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  // Method to find a product by id
  Product findById(String id) {
    return _items.firstWhere((p) => p.id == id);
  }

  Future<void> addProduct(Product product) {
    // Save to db first: Using Firebase
    final String productsCollection = '/products.json'; // .json for Firebase
    final url = Uri.parse('${this.endPoint}/$productsCollection');
    return http
        .post(
      url,
      body: json.encode({
        // json.encode comes from the dart:convert package
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        // 'id': DateTime.now().toString()
        'isFavorite': product.isFavorite,
      }),
    )
        .then((res) {
      // decode the response and get the body from id
      print(json.decode(res.body));
      // id from firebase will come as name on the body object
      final String newProductId = json.decode(res.body)['name'];
      // Get data from product
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        // id: DateTime.now().toString(),
        id: newProductId,
      );

      _items.add(newProduct); // adds the product at the end of the list
      // _items.insert(0, newProduct); // adds the product at the begining of the list
      // Notify other widgets of the changes
      notifyListeners();
    });
  }

  void updateProduct(String id, Product newProduct) {
    // Find the index of the product so you can update it
    final productIndex = _items.indexWhere((prod) => prod.id == id);
    if (productIndex >= 0) {
      _items[productIndex] = newProduct;
    } else {
      print('how did we get here?');
    }

    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
