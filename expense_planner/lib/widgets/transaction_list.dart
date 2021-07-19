import 'package:expense_planner/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transaction added yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 200.0,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5.0,
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: Text('\$${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(transactions[index].date),
                    ),

                    //   Card(
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         margin: EdgeInsets.symmetric(
                    //           vertical: 10,
                    //           horizontal: 15,
                    //         ),
                    //         decoration: BoxDecoration(
                    //             border: Border.all(
                    //           color: Theme.of(context).primaryColorDark,
                    //           width: 2,
                    //         )),
                    //         padding: EdgeInsets.all(10),
                    //         child: Text(
                    //           "\$${transactions[index].amount.toStringAsFixed(2)}",
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 20.0,
                    //               color: Theme.of(context).primaryColorDark),
                    //         ),
                    //       ),
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             transactions[index].title,
                    //             style: Theme.of(context).textTheme.headline6,
                    //           ),
                    //           Text(
                    //             DateFormat.yMMMd().format(transactions[index].date),
                    //             style: TextStyle(
                    //               color: Theme.of(context).primaryColor,
                    //             ),
                    //           )
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // );
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
