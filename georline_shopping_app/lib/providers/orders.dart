import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:georline_shopping_app/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  final String endPoint =
      'https://georline-shopping-flutter-test-default-rtdb.firebaseio.com';

  Future<void> fetchOrders() async {
    final String productsCollection = '/orders.json'; // .json for Firebase
    final url = Uri.parse('${this.endPoint}/$productsCollection');
    final response = await http.get(url);
    var tempOrder = [];
    if (json.decode(response.body) == null) return;

    json.decode(response.body).forEach((orderId, order) {
      List<CartItem> tempProducts = [];
      order['products'].forEach((p) {
        tempProducts.add(
          CartItem(
            id: p['id'],
            title: p['title'],
            quantity: p['quantity'],
            price: p['price'],
          ),
        );
      });
      tempOrder.add(
        OrderItem(
          id: orderId,
          amount: order['amount'],
          products: tempProducts,
          dateTime: DateTime.parse(order['dateTime']),
        ),
      );
    });
    // print(json.decode(response.body));
    _orders = [...tempOrder];
    notifyListeners();
  }

  List<OrderItem> get orders {
    // this.fetchOrders();
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final timeStamp = DateTime.now();

    final String productsCollection = '/orders.json'; // .json for Firebase
    final url = Uri.parse('${this.endPoint}/$productsCollection');
    var tempP = [];
    cartProducts.forEach((element) {
      tempP.add({
        'id': element.id,
        'title': element.title,
        'price': element.price,
        'quantity': element.quantity
      });
    });
    // print(tempP);
    // return;
    final response = await http.post(
      url,
      body: json.encode({
        'id': timeStamp.toString(),
        'amount': total,
        'dateTime': timeStamp.toIso8601String(),
        'products': tempP,
      }),
    );

    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timeStamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
