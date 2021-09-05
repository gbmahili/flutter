import 'package:flutter/material.dart';
import 'package:georline_shopping_app/providers/orders.dart' show Orders;
import 'package:georline_shopping_app/widgets/app_drawer.dart';
import 'package:georline_shopping_app/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static final String routeName = "/orders";
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (ctx, i) {
          return OrderItem(ordersData.orders[i]);
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
