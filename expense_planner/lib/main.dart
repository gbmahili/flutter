import 'package:expense_planner/models/transactions.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // late String titleInput;
  // late String amountInput;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Planner'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text('CHARTS'),
            ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    // onChanged: (val) {
                    //   titleInput = val;
                    // },
                    controller: titleController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Amount',
                    ),
                    // onChanged: (val) {
                    //   amountInput = val;
                    // },
                    controller: amountController,
                  ),
                  TextButton(
                    onPressed: () {
                      print(titleController.text);
                      print(amountController.text);
                    },
                    child: Text('Add Transaction',
                        style: TextStyle(
                          color: Colors.purple,
                        )),
                  )
                ],
              ),
            ),
          ),
          TransactionList(),
        ],
      ),
    );
  }
}
