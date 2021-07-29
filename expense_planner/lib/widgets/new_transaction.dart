import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  dynamic _selectedDate = '';

  void _submitData() {
    // Check if amount controller is empty to avoid submitting empty transactions.

    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    // Check if user entered title, amount and date before submitting.
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == '') {
      return;
    }

    widget.addTransaction(enteredTitle, enteredAmount, _selectedDate);

    // Close the last screen added (in our case, the transaction screen)
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    print(_selectedDate);
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((DateTime? pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom +
                10, // viewInsets contain the keyboard height
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // },
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   amountInput = val;
                // },
                controller: _amountController,
              ),
              Container(
                height: 70.0,
                child: Row(
                  children: [
                    Text(
                      _selectedDate == ''
                          ? "No Date Chosen!"
                          : DateFormat.yMMMMd().format(_selectedDate),
                    ),
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () => _submitData(),
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.button!.color,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
