import 'package:flutter/material.dart';
import 'package:georline_shopping_app/providers/orders.dart' show Orders;
import 'package:georline_shopping_app/widgets/app_drawer.dart';
import 'package:georline_shopping_app/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static final String routeName = "/orders";
//   const OrdersScreen({Key? key}) : super(key: key);

//   @override
//   _OrdersScreenState createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen> {
//   var _isLoading = false;
//   @override
//   void initState() {
//     Future.delayed(Duration.zero).then((_) async {
//       setState(() {
//         _isLoading = true;
//       });
//       await Provider.of<Orders>(context, listen: false).fetchOrders();
//       setState(() {
//         _isLoading = false;
//       });
//     });
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    // final ordersData = Provider.of<Orders>(context);
    print(
        'build should only call onces, uncomment above line and see that it will call multiple times');
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      // FutureBuilder is good if you don't want to turn Stateless widgets to statefull
      // just so you can controll isLoading or not...FutureBuilder will give you errors, waiting and data
      // as long as you provide it with whichever future you are waiting for .
      body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).fetchOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                // Do error handling here...
                return Center(
                  child: Text('An error occured!'),
                );
              } else {
                // To avoid infinite looping, use Consumer instead of Provider
                return Consumer<Orders>(builder: (ctx, ordersData, child) {
                  return ListView.builder(
                    itemCount: ordersData.orders.length,
                    itemBuilder: (ctx, i) {
                      return OrderItem(ordersData.orders[i]);
                    },
                  );
                });
              }
            }
          }),
      drawer: AppDrawer(),
    );
  }
}
